//
//  LoginViewController.m
//  sxxw
//
//  Created by yons on 15-4-7.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"用户登录";
    
    [self.navigationController setNavigationBarHidden:NO];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    _centerController = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"NViewController3"];
    
    _leftController = (ViewController2 *)[storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];
    
    
    [self.view addSubview:_centerController.view];
    [_centerController.view setTag:1];
    [_centerController.view setFrame:self.view.bounds];
    
    [self.view addSubview:_leftController.view];
    [_leftController.view setTag:2];
    [_leftController.view setFrame:self.view.bounds];
    
    [self.view bringSubviewToFront:_centerController.view];
    
    //add swipe gesture
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeGestureRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [_centerController.view addGestureRecognizer:swipeGestureRight];
    
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeGestureLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_centerController.view addGestureRecognizer:swipeGestureLeft];
}
-(void) swipeGesture:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
    
    CALayer *layer = [_centerController.view layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowOpacity = 1;
    layer.shadowRadius = 20.0;
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [_leftController.view setHidden:NO];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        if (_centerController.view.frame.origin.x == self.view.frame.origin.x) {
            [_centerController.view setFrame:CGRectMake(_centerController.view.frame.origin.x+200, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
            
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCenter:)];
            [_centerController.view addGestureRecognizer:tapGesture];
        }
        
        [UIView commitAnimations];
    }
}

-(void) tapCenter:(UITapGestureRecognizer *)tapGestureRecognizer {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    if (_centerController.view.frame.origin.x == self.view.frame.origin.x + 200) {
        [_centerController.view setFrame:CGRectMake(0, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
        [_centerController.view removeGestureRecognizer:tapGestureRecognizer];
    }
    
    [UIView commitAnimations];
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
