//
//  MessageDelegate.h
//  JabberClient
//
//  Created by Antonio on 31/8/15.
//  Copyright (c) 2015 Antonio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageDelegate <NSObject>
- (void)newMessageReceived:(NSDictionary *)messageContent;
@end
