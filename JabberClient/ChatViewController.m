//
//  ChatViewController.m
//  JabberClient
//
//  Created by Antonio on 31/8/15.
//  Copyright (c) 2015 Antonio. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *messages;

@end

@implementation ChatViewController

- (instancetype)initWithUser:(NSString *)userName {
    self = [super init];
    
    if (self) {
        _chatWithUser = userName;
        _messages = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.messageField becomeFirstResponder];
}


#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *message = (NSDictionary *) [self.messages objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"MessageCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [message objectForKey:@"msg"];
    cell.detailTextLabel.text = [message objectForKey:@"sender"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.userInteractionEnabled = NO;
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}


- (IBAction)sendMessage:(UIButton *)sender {
    NSString *messageString = self.messageField.text;
    if (messageString.length > 0) {
        // send meddage through XMPP
        self.messageField.text = @"";
        NSString *messageYou = [NSString stringWithFormat:@"%@:%@", messageString, @"you"];
        NSMutableDictionary *messageDict = [NSMutableDictionary dictionary];
        [messageDict setObject:messageString forKey:@"msg"];
        [messageDict setObject:@"you" forKey:@"sender"];
        [self.messages addObject:messageDict];
        [self.tableView reloadData];
    }
}

- (IBAction)closeChat:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
