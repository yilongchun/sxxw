//
//  UserRegisterViewController.m
//  sxxw
//
//  Created by yons on 15-4-16.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "IQKeyboardManager.h"
#import "LoginViewController.h"

@interface UserRegisterViewController ()

@end

@implementation UserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户注册";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"账号:";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor clearColor];
    self.username.leftViewMode = UITextFieldViewModeAlways;
    self.username.leftView = label;
    self.username.borderStyle=UITextBorderStyleNone;
    [self.username.layer setMasksToBounds:YES];
    [self.username.layer setBorderWidth:0.6f];
    [self.username.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"密码:";
    label2.textColor = [UIColor grayColor];
    label2.font = [UIFont systemFontOfSize:14];
    label2.backgroundColor = [UIColor clearColor];
    self.password1.leftViewMode = UITextFieldViewModeAlways;
    self.password1.leftView = label2;
    self.password1.borderStyle=UITextBorderStyleNone;
    [self.password1.layer setMasksToBounds:YES];
    [self.password1.layer setBorderWidth:0.6f];
    [self.password1.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"确认:";
    label3.textColor = [UIColor grayColor];
    label3.font = [UIFont systemFontOfSize:14];
    label3.backgroundColor = [UIColor clearColor];
    self.password2.leftViewMode = UITextFieldViewModeAlways;
    self.password2.leftView = label3;
    self.password2.borderStyle=UITextBorderStyleNone;
    [self.password2.layer setMasksToBounds:YES];
    [self.password2.layer setBorderWidth:0.6f];
    [self.password2.layer setBorderColor:[UIColor lightGrayColor].CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)reg:(id)sender {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
}

- (IBAction)login:(id)sender {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    UINavigationController *nc = (UINavigationController *)self.sideMenuViewController.contentViewController;
    LoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [nc popToRootViewControllerAnimated:NO];
    [nc pushViewController:vc animated:YES];
    
}
@end
