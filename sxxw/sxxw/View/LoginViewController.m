//
//  LoginViewController.m
//  sxxw
//
//  Created by yons on 15-4-7.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import "LoginViewController.h"
#import "IQKeyboardManager.h"
#import "UserRegisterViewController.h"
#import "TFHpple.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0f];
    self.title = @"用户登录";
    
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
    self.password.leftViewMode = UITextFieldViewModeAlways;
    self.password.leftView = label2;
    self.password.borderStyle=UITextBorderStyleNone;
    [self.password.layer setMasksToBounds:YES];
    [self.password.layer setBorderWidth:0.6f];
    [self.password.layer setBorderColor:[UIColor lightGrayColor].CGColor];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login:(id)sender {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
    [self showHudInView:self.view hint:@"登录中"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"login" forKey:@"enews"];
    [parameters setValue:self.username.text forKey:@"username"];
    [parameters setValue:self.password.text forKey:@"password"];
    
    NSString *str = [NSString stringWithFormat:@"%@%@",API_HOST,API_TO_LOGIN_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager GET:str parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [NSString stringWithFormat:@"%@",[operation responseString]];
        NSLog(@"%@",result);
        [self hideHud];
        if ([result isEqualToString:@"1"]) {
            [self showHint:@"登录成功"];
            [self performSelector:@selector(back) withObject:nil afterDelay:1.5];
            NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
            [userdefault setValue:self.username.text forKey:@"username"];
            [userdefault setValue:self.password.text forKey:@"password"];
        }else{
            NSData  * data = [result dataUsingEncoding:NSUTF8StringEncoding];
            TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
            NSArray * elements  = [doc searchWithXPathQuery:@"//table[@class='tableborder']"];
            TFHppleElement * element = [elements objectAtIndex:0];
            NSArray *trs = [element childrenWithTagName:@"tr"];
            TFHppleElement * tr = [trs objectAtIndex:1];
            TFHppleElement * td = [tr firstChildWithTagName:@"td"];
            TFHppleElement * div = [td firstChildWithTagName:@"div"];
            TFHppleElement * b = [div firstChildWithTagName:@"b"];
            [self showHint:[b text]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [self hideHud];
        [self showHint:@"连接失败"];
    }];
}

- (IBAction)reg:(id)sender {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
    UINavigationController *nc = (UINavigationController *)self.sideMenuViewController.contentViewController;
    UserRegisterViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"UserRegisterViewController"];
    [nc popToRootViewControllerAnimated:NO];
    [nc pushViewController:vc animated:YES];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
