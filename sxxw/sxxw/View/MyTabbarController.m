//
//  MyTabbarController.m
//  sxxw
//
//  Created by yons on 15-4-7.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import "MyTabbarController.h"

#import "XDKAirMenuController.h"

#import "ViewController1.h"
#import "NewsViewController.h"


#import "ViewController2.h"
#import "ViewController3.h"

@interface MyTabbarController ()

@end

@implementation MyTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.navigationController setNavigationBarHidden:YES];
    
    UIImage *image = [UIImage imageNamed:@"menu-button"];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftMenu)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
    backItem.title = @"返回";
    
    NewsViewController *news1 = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
    news1.title = @"news1";
    NewsViewController *news2 = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
    news2.title = @"news2";
    NewsViewController *news3 = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
    news3.title = @"news3";
    ViewController1 *vc1 = [[ViewController1 alloc] initWithViewControllers:@[news1,news2,news3]];
    vc1.view.backgroundColor = BACKGROUND_COLOR;
    vc1.title = @"第一个";
    vc1.indicatorInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    vc1.indicator.backgroundColor = [UIColor colorWithRed:72/255.0 green:147/255.0 blue:219/255.0 alpha:1];
    
    
    ViewController2 *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
    ViewController3 *vc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController3"];
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:1];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:2];
    
    vc1.tabBarItem = item1;
    vc2.tabBarItem = item2;
    vc3.tabBarItem = item3;
    
    NSMutableArray *viewArr_ = [NSMutableArray arrayWithObjects:vc1,vc2,vc3,nil];
    self.viewControllers = viewArr_;
//
//    self.selectedIndex = 0;
//    [[self tabBar] setSelectedImageTintColor:[UIColor colorWithRed:116/255.0 green:176/255.0 blue:64/255.0 alpha:1]];
}

- (void)leftMenu{
    XDKAirMenuController *menu = [XDKAirMenuController sharedMenu];
    
    if (menu.isMenuOpened)
        [menu closeMenuAnimated];
    else
        [menu openMenuAnimated];
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

@end
