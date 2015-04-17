//
//  NewsDetailViewController.m
//  sxxw
//
//  Created by yons on 15-4-9.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "PinglunViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.mywebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    
    [self.pinglunview.layer setMasksToBounds:YES];
    [self.pinglunview.layer setBorderWidth:0.6f];
    [self.pinglunview.layer setBorderColor:[UIColor colorWithRed:203/255.0 green:204/255.0 blue:199/255.0 alpha:0.8f].CGColor];
    
    
    UIImage *img = [[UIImage imageNamed:@"toolbar_light_comment"] stretchableImageWithLeftCapWidth:60 topCapHeight:0];
    [self.pinglunBtn setBackgroundImage:img forState:UIControlStateNormal];
    UIImage *img2 = [[UIImage imageNamed:@"toolbar_light_comment_highlighted"] stretchableImageWithLeftCapWidth:60 topCapHeight:0];
    [self.pinglunBtn setBackgroundImage:img2 forState:UIControlStateHighlighted];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self showHudInView:self.view hint:@"加载中"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self hideHud];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self hideHud];
    [self showHint:@"加载失败"];
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

- (IBAction)pinglun:(id)sender {
    PinglunViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PinglunViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)shoucang:(id)sender {
}
@end
