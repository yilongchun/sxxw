//
//  ViewController1.h
//  sxxw
//
//  Created by yons on 15-4-7.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+PullLoad.h"
#import "RESideMenu.h"

@interface ViewController1 : UIViewController<UITableViewDataSource,UITableViewDelegate,PullDelegate>

@property int bclassid;
@property (weak, nonatomic) IBOutlet UIView *buttonBackground;

@end
