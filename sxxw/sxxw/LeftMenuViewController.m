//
//  LeftMenuViewController.m
//  sxxw
//
//  Created by yons on 15-4-16.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LoginViewController.h"
#import "UserRegisterViewController.h"
#import "TougaoViewController.h"
#import "GuanyuViewController.h"

#define cellIdentifier @"leftMenuCell"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0f];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.mytableview setTableFooterView:v];
    if ([self.mytableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.mytableview setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.mytableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.mytableview setLayoutMargins:UIEdgeInsetsZero];
    }
    
//    [self.mytableview registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0f];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    NSArray *titles = @[@"用户登录", @"用户注册", @"投稿反馈", @"关于我们"];
    NSArray *images = @[@"dengluicon", @"zhuceicon", @"tougaoicon", @"guanyuicon"];
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mytableview.frame.size.width, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
    if (indexPath.row == 0) {
        LoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        UINavigationController *nc = (UINavigationController *)self.sideMenuViewController.contentViewController;
        [nc popToRootViewControllerAnimated:NO];
        [nc pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1) {
        UserRegisterViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"UserRegisterViewController"];
        UINavigationController *nc = (UINavigationController *)self.sideMenuViewController.contentViewController;
        [nc popToRootViewControllerAnimated:NO];
        [nc pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2) {
        TougaoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TougaoViewController"];
        UINavigationController *nc = (UINavigationController *)self.sideMenuViewController.contentViewController;
        [nc popToRootViewControllerAnimated:NO];
        [nc pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3) {
        GuanyuViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GuanyuViewController"];
        vc.url = @"http://www.baidu.com";
        UINavigationController *nc = (UINavigationController *)self.sideMenuViewController.contentViewController;
        [nc popToRootViewControllerAnimated:NO];
        [nc pushViewController:vc animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
