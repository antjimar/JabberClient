//
//  JabberClientViewController.m
//  JabberClient
//
//  Created by Antonio on 25/8/15.
//  Copyright (c) 2015 Antonio. All rights reserved.
//

#import "JabberClientViewController.h"
#import "LoginViewController.h"

@interface JabberClientViewController ()

@end

@implementation JabberClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.onlineBuddies = [[NSMutableArray alloc] init];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]) {
        [self showLogin:nil];
    }
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *buddieName = (NSString *)[self.onlineBuddies objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCellIdentifier" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserCellIdentifier"];
    }
    cell.textLabel.text = buddieName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.onlineBuddies count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Start a chat
}


#pragma mark - Actions
- (IBAction)showLogin:(UIBarButtonItem *)sender {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    [self presentViewController:loginViewController animated:YES completion:^{
    }];
}
@end
