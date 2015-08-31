//
//  AppDelegate.h
//  JabberClient
//
//  Created by Antonio on 25/8/15.
//  Copyright (c) 2015 Antonio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatDelegate.h"
#import "MessageDelegate.h"

@class JabberClientViewController, XMPPStream;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) JabberClientViewController *jabberClientViewController;
@property (nonatomic, readonly) XMPPStream *xmppStream;
@property (nonatomic, copy) NSString *password;
@property (nonatomic) BOOL isOpen;

@property (nonatomic, weak) id<ChatDelegate> chatDelegate;
@property (nonatomic, weak) id<MessageDelegate> messageDelegate;

- (BOOL)connect;
- (void)disconnect;

@end

