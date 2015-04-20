//
//  NewsDetailViewController.h
//  sxxw
//
//  Created by yons on 15-4-9.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController<UIWebViewDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIView *pinglunview;
@property (weak, nonatomic) IBOutlet UIWebView *mywebview;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *newsid;
@property (nonatomic, strong) NSString *shareText;
@property (nonatomic, strong) NSString *shareImage;
@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;
- (IBAction)pinglun:(id)sender;
- (IBAction)share:(id)sender;

@end
