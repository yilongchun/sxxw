//
//  LeftMenuViewController.h
//  sxxw
//
//  Created by yons on 15-4-16.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface LeftMenuViewController : UIViewController<RESideMenuDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mytableview;
@end
