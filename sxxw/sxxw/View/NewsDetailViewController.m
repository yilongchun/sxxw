//
//  NewsDetailViewController.m
//  sxxw
//
//  Created by yons on 15-4-9.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "PinglunViewController.h"
#import "LoginViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reload)
                                                 name:@"reloadNewsDetail"
                                               object:nil];
    
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
//    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
//    NSString *username = [userdefault objectForKey:@"username"];
//    NSString *password = [userdefault objectForKey:@"password"];
//    if (username != nil && password != nil) {
        PinglunViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PinglunViewController"];
        vc.newsid = self.newsid;
        vc.classid = self.classid;
        [self.navigationController pushViewController:vc animated:YES];
//    }else{
//        if (CURRENT_VERSION >= 8.0) {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您未登录" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//            [alert addAction:[UIAlertAction actionWithTitle:@"立即登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                UINavigationController *nc = (UINavigationController *)self.sideMenuViewController.contentViewController;
//                LoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//                [nc pushViewController:vc animated:YES];
//            }]];
//            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController:alert animated:YES completion:nil];
//        }else{
//            UIActionSheet *alert = [[UIActionSheet alloc] initWithTitle:@"您未登录" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"立即登录" otherButtonTitles: nil];
//            alert.tag = 1;
//            [alert showInView:self.view];
//        }
//    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0) {
            UINavigationController *nc = (UINavigationController *)self.sideMenuViewController.contentViewController;
            LoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [nc pushViewController:vc animated:YES];
        }
    }
}

- (IBAction)share:(id)sender {
    NSString *textToShare = self.shareText;
    UIImage *imageToShare = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImage]]];
    NSURL *urlToShare = [NSURL URLWithString:self.url];
    NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems  applicationActivities:nil];
    [self presentViewController:activityController  animated:YES completion:nil];
}

-(void)reload{
    [self.mywebview reload];
}

@end
