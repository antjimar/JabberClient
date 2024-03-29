//
//  ChatDelegate.h
//  JabberClient
//
//  Created by Antonio on 31/8/15.
//  Copyright (c) 2015 Antonio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChatDelegate <NSObject>
- (void)newBuddyOnline:(NSString *)buddyName;
- (void)buddyWentOffline:(NSString *)buddyName;
- (void)didDisconnect;
@end
