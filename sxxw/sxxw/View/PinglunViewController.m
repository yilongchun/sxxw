//
//  PinglunViewController.m
//  sxxw
//
//  Created by yons on 15-4-17.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import "PinglunViewController.h"
#import "IQKeyboardManager.h"
#import "TFHpple.h"

@interface PinglunViewController ()

@end

@implementation PinglunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发表评论";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"评论人:";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor clearColor];
    self.username.leftViewMode = UITextFieldViewModeAlways;
    self.username.leftView = label;
    self.username.borderStyle=UITextBorderStyleNone;
    [self.username.layer setMasksToBounds:YES];
    [self.username.layer setBorderWidth:0.6f];
    [self.username.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.content.layer setMasksToBounds:YES];
    [self.content.layer setBorderWidth:0.6f];
    [self.content.layer setBorderColor:[UIColor lightGrayColor].CGColor];
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

- (IBAction)save:(id)sender {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
    [self showHudInView:self.view hint:@"加载中"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *username = [userdefault objectForKey:@"username"];
    NSString *password = [userdefault objectForKey:@"password"];

    
    [parameters setValue:@"AddPl" forKey:@"enews"];
    [parameters setValue:username forKey:@"username"];
    [parameters setValue:password forKey:@"password"];
    [parameters setValue:self.newsid forKey:@"id"];
    [parameters setValue:@"login" forKey:@"classid"];
    [parameters setValue:self.content.text forKey:@"saytext"];
    
    
    NSString *str = [NSString stringWithFormat:@"%@%@",API_HOST,API_TO_COMMENT_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager GET:str parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [NSString stringWithFormat:@"%@",[operation responseString]];
        NSLog(@"%@",result);
        [self hideHud];
        if ([result isEqualToString:@"1"]) {
            [self showHint:@"评论成功"];
        }else{
            NSData  * data = [result dataUsingEncoding:NSUTF8StringEncoding];
            TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
            NSArray * elements  = [doc searchWithXPathQuery:@"//table[@class='tableborder']"];
            TFHppleElement * element = [elements objectAtIndex:0];
            NSArray *trs = [element childrenWithTagName:@"tr"];
            TFHppleElement * tr = [trs objectAtIndex:1];
            TFHppleElement * td = [tr firstChildWithTagName:@"td"];
            TFHppleElement * div = [td firstChildWithTagName:@"div"];
            TFHppleElement * b = [div firstChildWithTagName:@"b"];
            [self showHint:[b text]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [self hideHud];
        [self showHint:@"连接失败"];
    }];
}
@end
