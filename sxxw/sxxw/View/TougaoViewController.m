//
//  TougaoViewController.m
//  sxxw
//
//  Created by yons on 15-4-16.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import "TougaoViewController.h"
#import "IQKeyboardManager.h"
#import "QCheckBox.h"

@interface TougaoViewController ()<QCheckBoxDelegate>

@end

@implementation TougaoViewController{
    QCheckBox *oldButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"投稿反馈";
    
    
    QCheckBox *_check1 = [[QCheckBox alloc] initWithDelegate:self normal:[UIImage imageNamed:@"radio_checked"] selected:[UIImage imageNamed:@"radio_unchecked"]];
//    QCheckBox *_check1 = [[QCheckBox alloc] initWithDelegate:self];
    _check1.tag = 1;
    _check1.frame = CGRectMake(60, 5, 100, 30);
    [_check1 setTitle:@"信息交流" forState:UIControlStateNormal];
    [_check1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_check1.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_check1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.lanmu addSubview:_check1];
    
    QCheckBox *_check2 = [[QCheckBox alloc] initWithDelegate:self normal:[UIImage imageNamed:@"radio_checked"] selected:[UIImage imageNamed:@"radio_unchecked"]];
//    QCheckBox *_check2 = [[QCheckBox alloc] initWithDelegate:self];
    _check2.tag = 2;
    _check2.frame = CGRectMake(170, 5, 100, 30);
    [_check2 setTitle:@"观点碰撞" forState:UIControlStateNormal];
    [_check2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_check2.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_check2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.lanmu addSubview:_check2];
    
    QCheckBox *_check3 = [[QCheckBox alloc] initWithDelegate:self normal:[UIImage imageNamed:@"radio_checked"] selected:[UIImage imageNamed:@"radio_unchecked"]];
//    QCheckBox *_check3 = [[QCheckBox alloc] initWithDelegate:self];
    _check3.tag = 3;
    _check3.frame = CGRectMake(60, 45, 100, 30);
    [_check3 setTitle:@"热点推荐" forState:UIControlStateNormal];
    [_check3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_check3.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_check3 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.lanmu addSubview:_check3];
    
    self.lanmuLabel.textColor = [UIColor grayColor];
    [self.lanmu.layer setMasksToBounds:YES];
    [self.lanmu.layer setBorderWidth:0.6f];
    [self.lanmu.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"标题(*):";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor clearColor];
    self.titleText.leftViewMode = UITextFieldViewModeAlways;
    self.titleText.leftView = label;
    self.titleText.borderStyle=UITextBorderStyleNone;
    [self.titleText.layer setMasksToBounds:YES];
    [self.titleText.layer setBorderWidth:0.6f];
    [self.titleText.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"投稿人:";
    label2.textColor = [UIColor grayColor];
    label2.font = [UIFont systemFontOfSize:14];
    label2.backgroundColor = [UIColor clearColor];
    self.tougaouser.leftViewMode = UITextFieldViewModeAlways;
    self.tougaouser.leftView = label2;
    self.tougaouser.borderStyle=UITextBorderStyleNone;
    [self.tougaouser.layer setMasksToBounds:YES];
    [self.tougaouser.layer setBorderWidth:0.6f];
    [self.tougaouser.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.content.layer setMasksToBounds:YES];
    [self.content.layer setBorderWidth:0.6f];
    [self.content.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
}

-(void)click:(QCheckBox *)button{
    if (button.tag != oldButton.tag) {
        [oldButton setChecked:NO];
    }
    if ([button checked]) {
        oldButton = button;
    }else{
        oldButton = nil;
    }
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

- (IBAction)takePicture:(id)sender {
    NSLog(@"takePicture");
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
}

- (IBAction)choosePicture:(id)sender {
    NSLog(@"choosePicture");
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
}

- (IBAction)save:(id)sender {
    NSLog(@"save");
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
}
@end
