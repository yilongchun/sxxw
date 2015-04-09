//
//  NewsTableViewCell.h
//  sxxw
//
//  Created by yons on 15-4-9.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *newsimage;
@property (weak, nonatomic) IBOutlet UILabel *newstitle;
@property (weak, nonatomic) IBOutlet UILabel *newscontent;
@property (weak, nonatomic) IBOutlet UILabel *newsreplynum;
@end
