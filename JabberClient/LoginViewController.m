//
//  LoginViewController.m
//  JabberClient
//
//  Created by Antonio on 25/8/15.
//  Copyright (c) 2015 Antonio. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)login:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] setObject:self.loginField.text forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] setObject:self.passwordField.text forKey:@"userPassword"];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)hideLogin:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
