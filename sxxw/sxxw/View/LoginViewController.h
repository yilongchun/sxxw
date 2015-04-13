//
//  LoginViewController.h
//  sxxw
//
//  Created by yons on 15-4-7.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController2.h"


@interface LoginViewController : UIViewController

@property(nonatomic, strong) ViewController2 *leftController;
@property(nonatomic, strong) UINavigationController *centerController;

@end
