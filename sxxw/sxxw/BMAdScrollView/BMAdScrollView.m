//
//  BMAdScrollView.m
//  UIPageController
//
//  Created by skyming on 14-5-31.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMAdScrollView.h"
//#import "UrlImageButton.h"

#define WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define PAGE_HEIGHT 37
#define rightDirection 1
#define zeroDirection 0
#define INTERVALE 8

@implementation BMButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end


@implementation BMImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            
    }
    return self;
}

//新定义初始化视图方法
-(id)initWithImageName:(NSString *)imageName title:(NSString *)titleStr x:(CGFloat)xPoint tFrame:(CGRect)titleFrame iHeight:(CGFloat)imageHeight titleHidden:(BOOL)isTitleHidden
{
    //调用原始初始化方法
    CGFloat imageH = imageHeight;
//    if ( !isTitleHidden) {
//        imageH = imageHeight - 30;
//    }
    self = [super initWithFrame:CGRectMake(xPoint, 0, CGRectGetWidth([UIScreen mainScreen].bounds), imageH)];
    if (self) {
        // Initialization code
        //设置图片视图
//        UrlImageButton *imageView = [[UrlImageButton alloc]initWithFrame:CGRectMake(0, 0, 320, imageH)];
        BMButton *imageView = [[BMButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), imageH)];
        //给定网络图片路径
//     [imageView setImageFromUrl:YES withUrl:imageName];
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]]];
        
        [imageView setImage:image forState:UIControlStateNormal];
//        [imageView setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageName]];
        //设置点击方法
        [imageView addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imageView];
        
        if (isTitleHidden) {
            return self;
        }
        //设置背景条
        if (titleFrame.size.height == 0.0) {
            titleFrame = CGRectMake(0, self.frame.size.height - 30, CGRectGetWidth([UIScreen mainScreen].bounds), 30);
        }
        
        UIView *titleBack = [[UIView alloc]initWithFrame:titleFrame];
        titleBack.backgroundColor =[UIColor grayColor];
        titleBack.alpha = 0.7;
        [self addSubview:titleBack];
        
        //设置标题文字
        CGRect titleRect = titleFrame;
        titleRect.origin.x += 10;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleRect.origin.x, titleRect.origin.y, titleRect.size.width-55, titleRect.size.height)];
        titleLabel.text=titleStr;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.backgroundColor =[UIColor clearColor];
        titleLabel.textColor=[UIColor whiteColor];
        titleLabel.alpha = 1.0;
        [self addSubview:titleLabel];
        
        // NSLog(@"%@,%@,%@",imageView,titleStr,self);
    }
    return self;
}

-(void)click{
    [self.uBdelegate click:self.tag];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end

@interface BMAdScrollView()<UIScrollViewDelegate,UrLImageButtonDelegate>
{
    int switchDirection;//方向
//    CGFloat offsetY;
    NSMutableArray *imageNameArr;//图片数组
    NSMutableArray *titleStrArr;//标题数组
    
    UIScrollView *imageSV;//滚动视图
    UIPageControl *pageControl;
    
    NSInteger tempIndex;
    BOOL flag;
}
@end
static  int pageNumber;//页码

@implementation BMAdScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
//自定义实例化方法

- (instancetype)initWithNameArr:(NSMutableArray *)imageArr titleArr:(NSMutableArray *)titleArr height:(float)heightValue offsetY:(CGFloat)offsetY {
    
    self = [super initWithFrame:CGRectMake(0, offsetY, WIDTH, heightValue)];
    
    if (self) {
        
        pageNumber=0;//设置当前页为1
        imageNameArr = imageArr;
        titleStrArr=titleArr;

        [self addADScrollView:imageArr.count height:heightValue];
        [self addImages:imageArr titles:titleArr];
        [self addPageControl:imageArr.count];
        
      //设置NSTimer
        _timer = [NSTimer scheduledTimerWithTimeInterval:INTERVALE target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
        flag = YES;
        
    }
    return self;
}
- (void)addADScrollView:(NSInteger)count height:(CGFloat)heightValue
{
    //初始化scrollView
    imageSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, heightValue)];
    //设置sview属性
    
    imageSV.directionalLockEnabled = YES;//锁定滑动的方向
    imageSV.pagingEnabled = YES;//滑到subview的边界
    imageSV.bounces = NO;
    imageSV.delegate = self;
    imageSV.showsVerticalScrollIndicator = NO;//不显示垂直滚动条
    imageSV.showsHorizontalScrollIndicator = NO;//不显示水平滚动条
    
    CGSize newSize = CGSizeMake(WIDTH * (count + 2),  imageSV.bounds.size.height);//设置scrollview的大小
    [imageSV setContentSize:newSize];
    [self addSubview:imageSV];

}
- (void)addImages:(NSArray *)imageArr titles:(NSArray *)titleArr
{
    //添加图片视图
//    for (int i = 0; i < imageArr.count && !isRepeat; i++) {
//        
//        NSString *title = @"";
//        NSString *imageURL = @"";
//        if (i < titleStrArr.count) {
//            title = titleArr[i];
//            imageURL = imageArr[i];
//        }
//
//        //创建内容对象
//        CGRect titleRect = CGRectMake(0, 150, 320, 30);
//        BMImageView *imageView =  [[BMImageView alloc]initWithImageName:imageURL title:title x:WIDTH*i tFrame:titleRect iHeight:imageSV.frame.size.height titleHidden:NO];
//        
//        //制定AOView委托
//        imageView.uBdelegate = self;
//        //设置视图标示
//        imageView.tag = i;
//        //添加视图
//        [imageSV addSubview:imageView];
//    }
//
    for (int i = 0; i <= imageArr.count +1; i++) {
        
        NSString *title = @"";
        NSString *imageURL = @"";
        if (i != titleStrArr.count +1 && i != 0) {
            title = titleArr[i - 1];
            imageURL = imageArr[i - 1];
        }
        if (i == 0) {
            title = titleArr[titleArr.count - 1];
            imageURL = imageArr[imageArr.count - 1];
        }else if(i == titleArr.count +1)
        {
            title = titleArr[0];
            imageURL = imageArr[0];
        }
        //创建内容对象
        CGRect titleRect = CGRectMake(0, self.frame.size.height-30, CGRectGetWidth([UIScreen mainScreen].bounds), 30);
        BMImageView *imageView =  [[BMImageView alloc]initWithImageName:imageURL title:title x:WIDTH*i tFrame:titleRect iHeight:imageSV.frame.size.height titleHidden:NO];
        
        //制定AOView委托
        imageView.uBdelegate = self;
        //设置视图标示
        imageView.tag = i;
        //添加视图
        [imageSV addSubview:imageView];
    }
    [imageSV setContentOffset:CGPointMake(0, 0)];
    [imageSV scrollRectToVisible:CGRectMake(WIDTH,0,WIDTH,self.frame.size.height) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页

}
- (void)addPageControl:(NSInteger)count
{
    CGRect rect =  CGRectMake(0, 180, 50, 30);
    pageControl = [[UIPageControl alloc]initWithFrame:rect];
    pageControl.userInteractionEnabled = NO;
    if (_pageCenter.y == 0.0) {
        _pageCenter.y = self.frame.size.height - 15;
        _pageCenter.x = pageControl.center.x;
    }
    pageControl.center = _pageCenter;
    pageControl.numberOfPages = count;
    pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
    tempIndex = 0;
    
}
//NSTimer方法
//-(void)changeView:(NSTimer *)timer
//{
//    NSLog(@"changeView");
//
//    BOOL isAuto = timer != nil;
//    if (pageNumber == imageNameArr.count) {
//        [imageSV setContentOffset:CGPointMake(WIDTH*pageNumber, 0) animated:YES];
//        pageNumber = 0;
//        [imageSV setContentOffset:CGPointMake(WIDTH*pageNumber, 0) animated:YES];
//        pageControl.currentPage = pageNumber;
//        return ;
//    }
//    //修改页码
//    if (pageNumber == 0 && isAuto) {
//        switchDirection = rightDirection;
//    }else if(pageNumber >= imageNameArr.count-1 && isAuto){
//        switchDirection = zeroDirection;
//    }
//    
//    if (switchDirection == rightDirection && isAuto) {
//        pageNumber ++;
//    }else if (switchDirection == zeroDirection && isAuto){
//        pageNumber = 0;
//    }
//    
//    //page++;
//    //    //判断是否大于上线
//    //    if (page==imageNameArr.count) {
//    //        //重置页码
//    //        page=0;
//    //    }
//    //设置滚动到第几页
//    [imageSV setContentOffset:CGPointMake(WIDTH*pageNumber, 0) animated:YES];
//    pageControl.currentPage = pageNumber;
//    
//    
//}

- (void)setPageCenter:(CGPoint)pageCenter
{
    pageControl.center = pageCenter;
}
//// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSLog(@"scrollViewDidEndDragging");
//    
//}

    // called when scroll view grinds to a halt
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    NSLog(@"scrollViewDidEndDecelerating");
//    CGPoint offset = scrollView.contentOffset;
//    pageNumber = (offset.x  + WIDTH * 0.5)/ WIDTH; // 0 1 2
//    NSLog(@"%f  %d",offset.x,pageNumber);
//    [self changeView:nil];
//
//}
// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = imageSV.frame.size.width;
    int page = floor((imageSV.contentOffset.x - pagewidth/([imageNameArr count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    tempIndex = page;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    flag = NO;
}

// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    flag = YES;
    CGFloat pagewidth = imageSV.frame.size.width;
    int currentPage = floor((imageSV.contentOffset.x - pagewidth/ ([imageNameArr count]+2)) / pagewidth) + 1;
    if (currentPage==0)
    {
        [imageSV scrollRectToVisible:CGRectMake(WIDTH * [imageNameArr count],0,WIDTH,HEIGHT) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([imageNameArr count]+1))
    {
        [imageSV scrollRectToVisible:CGRectMake(WIDTH,0,WIDTH,HEIGHT) animated:NO]; // 最后+1,循环第1页
    }
    pageControl.currentPage = tempIndex;
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    NSInteger page = pageControl.currentPage; // 获取当前的page
    page++;
    page = page > imageNameArr.count-1 ? 0 : page ;
    tempIndex = page;
    
    [imageSV scrollRectToVisible:CGRectMake(WIDTH*(page+1),0,WIDTH,HEIGHT) animated:YES]; // 触摸pagecontroller那个点点 往后翻一页 +1
    pageControl.currentPage = page;
}
// 定时器 绑定的方法
- (void)runTimePage
{
    if (flag) {
        [self turnPage];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
#pragma UBdelegate
-(void)click:(NSInteger)vid{
    //调用委托实现方法
    [self.vDelegate buttonClick:vid];
}
@end
