//
//  TableCell3.h
//  sxxw
//
//  Created by tw on 13-11-21.
//  Copyright (c) 2013年 com.tght. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsTableViewCell.h"
@interface TableCell3 : UITableViewCell{
    
    IBOutlet UIScrollView *sv;
    IBOutlet UIPageControl *page;
    IBOutlet UILabel *titleimg;
    int TimeNum;
    BOOL Tend;
    
     NSMutableArray *Arr;
     NSMutableArray *Arr2;
     NSMutableArray *Arr3;
     NSMutableArray *Arr4;
}

- (UIScrollView *) getSv:(NSMutableArray *) newsarray;


- (void) setstatus:(UIScrollView *) mysv;
 @end
