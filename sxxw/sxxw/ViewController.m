//
//  ViewController.m
//  sxxw
//
//  Created by yons on 15-4-7.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import "ViewController.h"

#import "LoginViewController.h"

#import "ViewController1.h"
#import "NewsViewController.h"

@interface ViewController () <XDKAirMenuDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation ViewController{
    UINavigationController *vc;
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.airMenuController = [XDKAirMenuController sharedMenu];
    self.airMenuController.airDelegate = self;
    //self.airMenuController.isMenuOnRight = TRUE;
    
    [self.view addSubview:self.airMenuController.view];
    [self addChildViewController:self.airMenuController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TableViewSegue"])
    {
        self.tableView = ((UITableViewController*)segue.destinationViewController).tableView;
    }
}


#pragma mark - XDKAirMenuDelegate

- (UIViewController*)airMenu:(XDKAirMenuController*)airMenu viewControllerAtIndexPath:(NSIndexPath*)indexPath
{
    
    if (vc == nil) {
        NewsViewController *news1 = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
        news1.title = @"时事要闻";
        NewsViewController *news2 = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
        news2.title = @"特别报道";
        NewsViewController *news3 = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
        news3.title = @"图文副刊";
        ViewController1 *vc1 = [[ViewController1 alloc] initWithViewControllers:@[news1,news2,news3]];
        vc1.view.backgroundColor = BACKGROUND_COLOR;
        vc1.title = @"中国三峡工程报";
        vc1.indicatorInsets = UIEdgeInsetsMake(0, 0, 8, 0);
        vc1.indicator.backgroundColor = [UIColor colorWithRed:72/255.0 green:147/255.0 blue:219/255.0 alpha:1];
        vc = [[UINavigationController alloc] initWithRootViewController:vc1];
    }
    vc.view.autoresizesSubviews = TRUE;
    vc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    
    
    
    if (indexPath.row == 0){
        
    }else if (indexPath.row == 1){
        [vc popToRootViewControllerAnimated:NO];
        LoginViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [vc pushViewController:login animated:YES];
    }else if (indexPath.row == 3){
        
    }

    return vc;
}

- (UITableView*)tableViewForAirMenu:(XDKAirMenuController*)airMenu
{
    return self.tableView;
}

- (CGFloat)widthControllerForAirMenu:(XDKAirMenuController*)airMenu{
    return 120;
}

- (CGFloat)minScaleControllerForAirMenu:(XDKAirMenuController*)airMenu{
    return 1;
}

- (CGFloat)minScaleTableViewForAirMenu:(XDKAirMenuController*)airMenu{
    return 1;
}

- (CGFloat)minAlphaTableViewForAirMenu:(XDKAirMenuController*)airMenu{
    return 1;
}

@end
