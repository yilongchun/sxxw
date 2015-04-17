//
//  UserRegisterViewController.h
//  sxxw
//
//  Created by yons on 15-4-16.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserRegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *password2;
- (IBAction)reg:(id)sender;
- (IBAction)login:(id)sender;
@end
