//
//  GuanyuViewController.h
//  sxxw
//
//  Created by yons on 15-4-16.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuanyuViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *mywebview;
@property (nonatomic, strong) NSString *url;

@end
