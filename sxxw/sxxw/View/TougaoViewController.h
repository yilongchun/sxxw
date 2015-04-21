//
//  TougaoViewController.h
//  sxxw
//
//  Created by yons on 15-4-16.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCImagePickerHeader.h"

@interface TougaoViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,ELCImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIScrollView *myscrollview;
@property (weak, nonatomic) IBOutlet UILabel *lanmuLabel;
@property (weak, nonatomic) IBOutlet UIView *lanmu;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *tougaouser;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UIScrollView *imagescrollview;
- (IBAction)takePicture:(id)sender;
- (IBAction)choosePicture:(id)sender;
- (IBAction)save:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imagescrollviewLayoutConstraint;
@property (assign,nonatomic) CGPoint scrollviewContentOffsetChange;

@end
