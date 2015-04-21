//
//  MyTabbarController.m
//  sxxw
//
//  Created by yons on 15-4-7.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import "MyTabbarController.h"
#import "ViewController1.h"

@interface MyTabbarController ()

@end

@implementation MyTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }else{
        UIApplication *application = [UIApplication sharedApplication];
        [application setStatusBarHidden:NO];
    }
    
    [self.navigationController setNavigationBarHidden:YES];
    
//    UIImage *image = [UIImage imageNamed:@"menu-button"];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftMenu)];
//    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
    backItem.title = @"返回";
    
//    NewsViewController *news1 = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
//    news1.title = @"news1";
//    NewsViewController *news2 = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
//    news2.title = @"news2";
//    NewsViewController *news3 = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
//    news3.title = @"news3";
//    ViewController1 *vc1 = [[ViewController1 alloc] initWithViewControllers:@[news1,news2,news3]];
//    vc1.view.backgroundColor = BACKGROUND_COLOR;
//    vc1.title = @"第一个";
//    vc1.indicatorInsets = UIEdgeInsetsMake(0, 0, 8, 0);
//    vc1.indicator.backgroundColor = [UIColor colorWithRed:72/255.0 green:147/255.0 blue:219/255.0 alpha:1];
//    
    ViewController1 *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController1"];
    vc1.bclassid = 2;
    vc1.detailTitle = @"中国三峡工程报";
    ViewController1 *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController1"];
    vc2.bclassid = 3;
    vc2.detailTitle = @"中国三峡杂志";
    ViewController1 *vc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController1"];
    vc3.bclassid = 4;
    vc3.detailTitle = @"清洁能源论坛";
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"中国三峡工程报" image:[UIImage imageNamed:@"01"] tag:1];
    
    
    
    
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"中国三峡杂志" image:[UIImage imageNamed:@"02"] tag:2];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"清洁能源论坛" image:[UIImage imageNamed:@"03"] tag:3];
    
    vc1.tabBarItem = item1;
    vc2.tabBarItem = item2;
    vc3.tabBarItem = item3;
    
    NSMutableArray *viewArr_ = [NSMutableArray arrayWithObjects:vc1,vc2,vc3,nil];
    self.viewControllers = viewArr_;

    self.selectedIndex = 0;
//    [[self tabBar] setSelectedImageTintColor:[UIColor colorWithRed:116/255.0 green:176/255.0 blue:64/255.0 alpha:1]];
    
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"select" forKey:@"dealType"];
    [parameters setValue:@"5" forKey:@"classid"];
    NSString *str = [NSString stringWithFormat:@"%@%@",API_HOST,API_GET_NEWS_LIST];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager GET:str parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hideHud];
//        NSLog(@"JSON: %@", operation.responseString);
        NSString *result = [NSString stringWithFormat:@"%@",[operation responseString]];
        NSError *error;
        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        if (info == nil) {
            NSLog(@"json parse failed \r\n");
        }else{
            NSString *titlepic = [info objectForKey:@"titlepic"];
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
            [imageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_HOST,titlepic]]];
            imageview.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
            [imageview addGestureRecognizer:tap];
            [view addSubview:imageview];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self action:@selector(theButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"点击进入" forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            button.frame = CGRectMake(0, imageview.frame.size.height, self.view.frame.size.width, 50.0);
            [view addSubview:button];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [view removeFromSuperview];
    }];
}

-(void)theButtonClick:(UIButton *)btn{
    [btn.superview removeFromSuperview];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    
    if (item.tag == 1) {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setValue:@"select" forKey:@"dealType"];
        [parameters setValue:@"5" forKey:@"classid"];
        NSString *str = [NSString stringWithFormat:@"%@%@",API_HOST,API_GET_NEWS_LIST];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        [manager GET:str parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self hideHud];
//            NSLog(@"JSON: %@", operation.responseString);
            NSString *result = [NSString stringWithFormat:@"%@",[operation responseString]];
            NSError *error;
            NSDictionary *info = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
            if (info == nil) {
                NSLog(@"json parse failed \r\n");
            }else{
                NSString *titlepic = [info objectForKey:@"titlepic"];
                UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
                [imageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_HOST,titlepic]]];
                imageview.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
                [imageview addGestureRecognizer:tap];
                [view addSubview:imageview];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button addTarget:self action:@selector(theButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:@"点击进入" forState:UIControlStateNormal];
                [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                button.frame = CGRectMake(0, imageview.frame.size.height, self.view.frame.size.width, 50.0);
                [view addSubview:button];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"发生错误！%@",error);
            [view removeFromSuperview];
            [self showHint:@"连接失败"];
        }];
    }else if(item.tag == 2){
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setValue:@"select" forKey:@"dealType"];
        [parameters setValue:@"6" forKey:@"classid"];
        NSString *str = [NSString stringWithFormat:@"%@%@",API_HOST,API_GET_NEWS_LIST];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        [manager GET:str parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self hideHud];
//            NSLog(@"JSON: %@", operation.responseString);
            NSString *result = [NSString stringWithFormat:@"%@",[operation responseString]];
            NSError *error;
            NSDictionary *info = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
            if (info == nil) {
                NSLog(@"json parse failed \r\n");
            }else{
                NSString *titlepic = [info objectForKey:@"titlepic"];
                UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
                [imageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_HOST,titlepic]]];
                imageview.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
                [imageview addGestureRecognizer:tap];
                [view addSubview:imageview];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button addTarget:self action:@selector(theButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:@"点击进入" forState:UIControlStateNormal];
                [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                button.frame = CGRectMake(0, imageview.frame.size.height, self.view.frame.size.width, 50.0);
                [view addSubview:button];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"发生错误！%@",error);
            [view removeFromSuperview];
            [self showHint:@"连接失败"];
        }];
    }else if(item.tag == 3){
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setValue:@"select" forKey:@"dealType"];
        [parameters setValue:@"9" forKey:@"classid"];
        NSString *str = [NSString stringWithFormat:@"%@%@",API_HOST,API_GET_NEWS_LIST];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        [manager GET:str parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self hideHud];
//            NSLog(@"JSON: %@", operation.responseString);
            NSString *result = [NSString stringWithFormat:@"%@",[operation responseString]];
            NSError *error;
            NSDictionary *info = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
            if (info == nil) {
                NSLog(@"json parse failed \r\n");
            }else{
                NSString *titlepic = [info objectForKey:@"titlepic"];
                UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
                [imageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_HOST,titlepic]]];
                imageview.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
                [imageview addGestureRecognizer:tap];
                [view addSubview:imageview];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button addTarget:self action:@selector(theButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:@"点击进入" forState:UIControlStateNormal];
                [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                button.frame = CGRectMake(0, imageview.frame.size.height, self.view.frame.size.width, 50.0);
                [view addSubview:button];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"发生错误！%@",error);
            [view removeFromSuperview];
            [self showHint:@"连接失败"];
        }];
    }
}

-(void)clickImage:(UITapGestureRecognizer *)gesture{
    [gesture.view.superview removeFromSuperview];
//    NSLog(@"%@",gesture.view);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
