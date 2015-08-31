//
//  JabberClientViewController.h
//  JabberClient
//
//  Created by Antonio on 25/8/15.
//  Copyright (c) 2015 Antonio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JabberClientViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *onlineBuddies;

- (IBAction)showLogin:(UIBarButtonItem *)sender;

@end

