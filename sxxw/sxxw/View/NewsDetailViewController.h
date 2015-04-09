//
//  NewsDetailViewController.h
//  sxxw
//
//  Created by yons on 15-4-9.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *mywebview;
@property (nonatomic, strong) NSString *url;
@end
