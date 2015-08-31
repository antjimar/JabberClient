//
//  AppDelegate.m
//  JabberClient
//
//  Created by Antonio on 25/8/15.
//  Copyright (c) 2015 Antonio. All rights reserved.
//

#import "AppDelegate.h"
#import "XMPP.h"

@interface AppDelegate ()
@property (nonatomic, strong) XMPPStream *xmppStream;
- (void)setupStream;
- (void)goOnline;
- (void)goOffline;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    [self disconnect];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self connect];
}
- (void)applicationWillTerminate:(UIApplication *)application {
}

#pragma mark - XMPPFramework
- (void)setupStream {
    self.xmppStream = [[XMPPStream alloc] init];
    [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}
- (void)goOnline {
    XMPPPresence *presence = [XMPPPresence presence];
    [[self xmppStream] sendElement:presence];
}
- (void)goOffline {
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [[self xmppStream] sendElement:presence];
}
- (BOOL)connect {
    [self setupStream];
    NSString *jabberID = [[NSUserDefaults standardUserDefaults] stringForKey:@"userID"];
    NSString *myPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"userPassword"];
    if (![self.xmppStream isDisconnected]) {
        return YES;
    }
    if (jabberID == nil || myPassword == nil) {
        return NO;
    }
    
    [self.xmppStream setMyJID:[XMPPJID jidWithString:jabberID]];
    self.password = myPassword;
    
    NSError *error = nil;
    if (![self.xmppStream connectWithTimeout:15 error:&error]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Can't connect to server %@", [error localizedDescription]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    return YES;
}
- (void)disconnect {
    [self goOffline];
    [self.xmppStream disconnect];
}

#pragma mark - XMPP Delegates
- (void)xmppStreamDidConnect:(XMPPStream *)sender {
    // connection to the server successfull
    self.isOpen = YES;
    NSError *error = nil;
    [[self xmppStream] authenticateWithPassword:self.password error:&error];
}
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender {
    // authentication successful
    [self goOnline];
}
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message {
    // message received
    NSString *msg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    NSMutableDictionary *messageMutableDict = [[NSMutableDictionary alloc] init];
    [messageMutableDict setObject:msg forKey:@"msg"];
    [messageMutableDict setObject:from forKey:@"sender"];
    [self.messageDelegate newMessageReceived:messageMutableDict];
}
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence {
    // a buddy went offline/online
    NSString *presenceType = [presence type]; //online/offline
    NSString *myUsername = [[sender myJID] user];
    NSString *presenceFromUser = [[presence from] user];
    if (![presenceType isEqualToString:myUsername]) {
        if ([presenceType isEqualToString:@"available"]) {
            [self.chatDelegate newBuddyOnline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, @"example.local"]];
        } else if ([presenceType isEqualToString:@"unavailable"]) {
            [self.chatDelegate buddyWentOffline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, @"example.local"]];
        }
    }
    
}



















@end
