//
//  ChatViewController.h
//  JabberClient
//
//  Created by Antonio on 31/8/15.
//  Copyright (c) 2015 Antonio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (copy, nonatomic) NSString *chatWithUser;

- (instancetype)initWithUser:(NSString *)userName;

- (IBAction)sendMessage:(UIButton *)sender;
- (IBAction)closeChat:(UIBarButtonItem *)sender;

@end
