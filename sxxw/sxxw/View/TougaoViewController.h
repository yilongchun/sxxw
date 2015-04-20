//
//  TougaoViewController.h
//  sxxw
//
//  Created by yons on 15-4-16.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TougaoViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lanmuLabel;
@property (weak, nonatomic) IBOutlet UIView *lanmu;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *tougaouser;
@property (weak, nonatomic) IBOutlet UITextView *content;

- (IBAction)takePicture:(id)sender;
- (IBAction)choosePicture:(id)sender;
- (IBAction)save:(id)sender;

@end
