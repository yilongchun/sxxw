//
//  TableCell3.m
//  sxxw
//
//  Created by tw on 13-11-21.
//  Copyright (c) 2013年 com.tght. All rights reserved.
//

#import "TableCell3.h"
#import "NewsTableViewCell.h"

 @implementation TableCell3
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
     [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIScrollView *) getSv:(NSMutableArray *)newsarray{
    
    Arr=[[NSMutableArray alloc] init];
    Arr2=[[NSMutableArray alloc] init];
    Arr3=[[NSMutableArray alloc] init];
    for (NewsTableViewCell *news in newsarray) {
        NSString *temptitle  = news.title;
        NSString *temptitleimg  = news.newsimageurl;
        [Arr addObject:temptitleimg];
        [Arr3 addObject:temptitle];
    }
    Arr4 = newsarray;
    
    [self AdImg:Arr];
    [self setCurrentPage:page.currentPage];
    if([Arr3 count]>0){
        titleimg.text = [Arr3 objectAtIndex:0];
    }
    // UITapGestureRecognizer *tapGestureTel = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teleButtonEvent:)]autorelease];
    // [titleimg addGestureRecognizer:tapGestureTel];
    return sv;
}


-(void)AdImg:(NSArray*)arr{
     [sv setContentSize:CGSizeMake(CGRectGetWidth(self.bounds)*[arr count], 190)];
    page.numberOfPages=[arr count];
     for ( int i=0; i<[arr count]; i++) {
         NSString *url=[arr objectAtIndex:i];
         UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)*i, 0, CGRectGetWidth(self.bounds), 190)];
         [img setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defalut_pic"]];
         [sv addSubview:img];
     }
}
- (void) setCurrentPage:(NSInteger)secondPage {
     for (NSUInteger subviewIndex = 0; subviewIndex < [page.subviews count]; subviewIndex++) {
        UIImageView* subview = [page.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 12/2;
        size.width = 12/2;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,size.width,size.height)];
         if ([subview isKindOfClass:[UIImageView class]]) {
             if (subviewIndex == secondPage) [subview setImage:[UIImage imageNamed:@"selected.png"]];
             else [subview setImage:[UIImage imageNamed:@"unselected.png"]];
         }
    }
}

#pragma mark - 3秒换图片
- (void) handleTimer: (NSTimer *) timer
{
    if (TimeNum % 3 == 0 ) {
        if (!Tend) {
            page.currentPage++;
            if (page.currentPage==page.numberOfPages-1) {
                Tend=YES;
            }
        }else{
            page.currentPage--;
            if (page.currentPage==0) {
                Tend=NO;
            }
        }
        [UIView animateWithDuration:0.4 //速度0.7秒
                         animations:^{//修改坐标
                             sv.contentOffset = CGPointMake(page.currentPage*320,0);
                         }];
    }
    TimeNum ++;
}
#pragma mark - scrollView && page
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    page.currentPage=scrollView.contentOffset.x/320;
    titleimg.text = [Arr3 objectAtIndex:page.currentPage];
    [self setCurrentPage:page.currentPage];
}
- (void)setstatus:(UIScrollView *)mysv{
    page.currentPage=mysv.contentOffset.x/320;
    titleimg.text = [Arr3 objectAtIndex:page.currentPage];
    [self setCurrentPage:page.currentPage];
}
@end
