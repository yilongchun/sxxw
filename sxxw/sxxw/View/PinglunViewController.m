//
//  PinglunViewController.m
//  sxxw
//
//  Created by yons on 15-4-17.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import "PinglunViewController.h"

@interface PinglunViewController ()

@end

@implementation PinglunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发表评论";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"评论人:";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor clearColor];
    self.username.leftViewMode = UITextFieldViewModeAlways;
    self.username.leftView = label;
    self.username.borderStyle=UITextBorderStyleNone;
    [self.username.layer setMasksToBounds:YES];
    [self.username.layer setBorderWidth:0.6f];
    [self.username.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.content.layer setMasksToBounds:YES];
    [self.content.layer setBorderWidth:0.6f];
    [self.content.layer setBorderColor:[UIColor lightGrayColor].CGColor];
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

@end
