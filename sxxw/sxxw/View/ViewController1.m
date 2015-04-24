//
//  ViewController1.m
//  sxxw
//
//  Created by yons on 15-4-7.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import "ViewController1.h"
#import "XHMenu.h"
#import "XHScrollMenu.h"
#import "NewsTableViewCell.h"
#import "NewsDetailViewController.h"
#import "BMAdScrollView.h"
#import "NSString+HXAddtions.h"

@interface ViewController1 () <XHScrollMenuDelegate, UIScrollViewDelegate,ValueClickDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) XHScrollMenu *scrollMenu;
@property (nonatomic, strong) NSMutableArray *menus;
@property (nonatomic, assign) BOOL shouldObserving;
@end


@implementation ViewController1{
    NSMutableArray *dataSourceArray;
    NSMutableArray *tableArray;
    NSMutableArray *toppicnewsArray;
    CGFloat startX;
    CGFloat endX;
    
//    BMAdScrollView *adView;
    
}
@synthesize bclassid;

- (NSMutableArray *)menus {
    if (!_menus) {
        _menus = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _menus;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    dataSourceArray = [NSMutableArray array];
    toppicnewsArray = [NSMutableArray array];
    tableArray = [NSMutableArray array];
    
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
    backItem.title = @"返回";
    
//    [self.navigationController setNavigationBarHidden:YES];
//    self.view.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    
    self.shouldObserving = YES;
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1){
        _scrollMenu = [[XHScrollMenu alloc] initWithFrame:CGRectMake(40, 20, CGRectGetWidth(self.view.bounds)-40, 44)];
    }else{
        _scrollMenu = [[XHScrollMenu alloc] initWithFrame:CGRectMake(40, 0, CGRectGetWidth(self.view.bounds)-40, 44)];
    }
    _scrollMenu.backgroundColor = BACKGROUND_COLOR;
    _scrollMenu.indicatorTintColor = DEFAULT_BLUE_COLOR;
    _scrollMenu.hasShadowForBoth = NO;
    _scrollMenu.shouldUniformizeMenus = YES;
    _scrollMenu.delegate = self;
    //    _scrollMenu.selectedIndex = 3;
    [self.view addSubview:self.scrollMenu];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollMenu.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(_scrollMenu.frame))];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.tag = 999;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    
    
    [self loadClassList];
    
}

//加载第一级
-(void)loadClassList{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"select" forKey:@"dealType"];
    [parameters setValue:[NSNumber numberWithInt:bclassid] forKey:@"bclassid"];
    
    NSString *str = [NSString stringWithFormat:@"%@%@",API_HOST,API_GET_CLASS_LIST];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager GET:str parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSString *result = [NSString stringWithFormat:@"[%@]",[operation responseString]];
        
        NSError *error;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        if (array == nil) {
            NSLog(@"json parse failed \r\n");
        }else{
            for (int i = 0 ; i < array.count ; i++) {
                NSDictionary *info = [array objectAtIndex:i];
                NSString *classid = [info objectForKey:@"classid"];
//                NSLog(@"%@",classid);
                NSString *classname = [info objectForKey:@"classname"];
                    
            
                XHMenu *menu = [[XHMenu alloc] init];
                menu.menuid = classid;
                menu.title = classname;
                menu.titleNormalColor = [UIColor grayColor];
                menu.titleSelectedColor = DEFAULT_BLUE_COLOR;
                menu.titleFont = [UIFont boldSystemFontOfSize:16];
                [self.menus addObject:menu];
                
                
                NSObject *obj = [[NSObject alloc]init];
                [tableArray addObject:obj];
                NSMutableArray *dataSource = [NSMutableArray array];
                [dataSourceArray addObject:dataSource];
                NSMutableArray *dataSource2 = [NSMutableArray array];
                [toppicnewsArray addObject:dataSource2];
                
//                [table reloadData];
            }
            
            [_scrollView setContentSize:CGSizeMake(self.menus.count * CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_scrollView.bounds))];
            [self startObservingContentOffsetForScrollView:_scrollView];
            _scrollMenu.menus = self.menus;
            _scrollMenu.shouldUniformizeMenus = YES;
            [_scrollMenu reloadData];
        }
        [self loadTopPicNewsList];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [self hideHud];
        [self showHint:@"连接失败"];
    }];
}

-(void)loadTopPicNewsList{
    [self showHudInView:self.view hint:@"加载中"];
    NSObject *obj = [tableArray objectAtIndex:self.scrollMenu.selectedIndex];
    if (![obj isKindOfClass:[UITableView class]]) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(self.scrollMenu.selectedIndex * CGRectGetWidth(_scrollView.bounds), 0, CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_scrollView.bounds)-49) style:UITableViewStylePlain];
        table.dataSource = self;
        table.delegate = self;
        table.pullDelegate = self;
        table.canPullDown = YES;
        table.canPullUp = NO;
        if ([table respondsToSelector:@selector(setSeparatorInset:)]) {
            [table setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([table respondsToSelector:@selector(setLayoutMargins:)]) {
            [table setLayoutMargins:UIEdgeInsetsZero];
        }
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [table setTableFooterView:v];
        [_scrollView addSubview:table];
        [tableArray replaceObjectAtIndex:self.scrollMenu.selectedIndex withObject:table];
    }
    
    
    
    
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setValue:@"select" forKey:@"dealType"];
        [parameters setValue:@"7" forKey:@"classid"];
        NSString *str = [NSString stringWithFormat:@"%@%@",API_HOST,API_GET_NEWS_LIST];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        [manager GET:str parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSArray *dataSource = [NSArray array];
            [dataSourceArray replaceObjectAtIndex:self.scrollMenu.selectedIndex withObject:dataSource];
            
//            NSLog(@"JSON: %@", operation.responseString);
            //        NSArray *dataSource = [NSArray array];
            //        [toppicnewsArray replaceObjectAtIndex:self.scrollMenu.selectedIndex withObject:dataSource];
            NSString *result = [NSString stringWithFormat:@"[%@]",[operation responseString]];
            NSError *error;
            NSArray *array = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
            if (array == nil) {
                NSLog(@"json parse failed \r\n");
            }else{
                NSMutableArray *arr = [NSMutableArray array];
                for (int i = 0 ; i < 3; i++) {
                    NSDictionary *info = [array objectAtIndex:i];
                    NSString *title = [info objectForKey:@"title"];
                    NSString *titlepic = [info objectForKey:@"titlepic"];
                    NSString *newsid = [info objectForKey:@"id"];
                    NewsTableViewCell *news = [[NewsTableViewCell alloc] init];
                    news.newsid = newsid;
                    news.title = title;
                    news.titlepic = titlepic;
                    news.newsimageurl = [NSString stringWithFormat:@"%@%@",API_HOST,titlepic];
                    [arr addObject:news];
                }
                [toppicnewsArray replaceObjectAtIndex:self.scrollMenu.selectedIndex withObject:arr];
                NSMutableArray *arr2=[NSMutableArray array];
                NSMutableArray *strArr = [NSMutableArray array];
                //            NSMutableArray *toppicnews = [toppicnewsArray objectAtIndex:self.scrollMenu.selectedIndex];
                for (NewsTableViewCell *news in arr) {
                    NSString *temptitle  = news.title;
                    NSString *temptitleimg  = news.newsimageurl;
                    [arr2 addObject:temptitleimg];
                    [strArr addObject:temptitle];
                }
                if (arr2 != nil && arr2.count > 0) {
                    BMAdScrollView *adView = [[BMAdScrollView alloc] initWithNameArr:arr2  titleArr:strArr height:190.0f offsetY:0];
                    adView.vDelegate = self;
                    adView.pageCenter = CGPointMake([UIScreen mainScreen].bounds.size.width - 25, adView.frame.size.height-15);
                    adView.backgroundColor = [UIColor whiteColor];
                    
                    NSMutableArray *ad = [NSMutableArray arrayWithObject:adView];
                    [dataSourceArray replaceObjectAtIndex:self.scrollMenu.selectedIndex withObject:ad];
                    
                }
//                toppicnewsArray = [NSMutableArray array];
//                for (int i = 0; i < dataSourceArray.count; i++) {
//                    [toppicnewsArray addObject:adView];
//                }
            }
                    [self loadNewsList];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"发生错误！%@",error);
            [self hideHud];
            [self showHint:@"连接失败"];
            UITableView *table = [tableArray objectAtIndex:self.scrollMenu.selectedIndex];
            [table stopLoadWithState:PullDownLoadState];
        }];
    
}

-(void)loadNewsList{
    
    XHMenu *menu = [self.menus objectAtIndex:self.scrollMenu.selectedIndex];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"select" forKey:@"dealType"];
    [parameters setValue:menu.menuid forKey:@"classid"];
    NSString *str = [NSString stringWithFormat:@"%@%@",API_HOST,API_GET_NEWS_LIST];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager GET:str parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", operation.responseString);
        
        
        NSString *result = [NSString stringWithFormat:@"[%@]",[operation responseString]];
        NSError *error;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        if (array == nil) {
            NSLog(@"json parse failed \r\n");
        }else{
            NSMutableArray *ar = [dataSourceArray objectAtIndex:self.scrollMenu.selectedIndex];
            [ar addObjectsFromArray:array];
            [dataSourceArray replaceObjectAtIndex:self.scrollMenu.selectedIndex withObject:ar];
            UITableView *table = [tableArray objectAtIndex:self.scrollMenu.selectedIndex];
            [table reloadData];
            [table stopLoadWithState:PullDownLoadState];
        }
        [self hideHud];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [self hideHud];
        [self showHint:@"连接失败"];
        UITableView *table = [tableArray objectAtIndex:self.scrollMenu.selectedIndex];
        [table stopLoadWithState:PullDownLoadState];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startObservingContentOffsetForScrollView:(UIScrollView *)scrollView
{
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
}

- (void)stopObservingContentOffset
{
    if (self.scrollView) {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
        self.scrollView = nil;
    }
}

- (void)dealloc {
    [self stopObservingContentOffset];
}

- (void)scrollMenuDidSelected:(XHScrollMenu *)scrollMenu menuIndex:(NSUInteger)selectIndex {
    
//    NSLog(@"selectIndex : %lu", (unsigned long)selectIndex);
    self.shouldObserving = NO;
    [self menuSelectedIndex:selectIndex];
    if ([[dataSourceArray objectAtIndex:self.scrollMenu.selectedIndex] count] == 0) {
        [self loadTopPicNewsList];
    }
//    UITableView *table = [tableArray objectAtIndex:selectIndex];
//    [table reloadData];
}

- (void)scrollMenuDidManagerSelected:(XHScrollMenu *)scrollMenu {
    NSLog(@"scrollMenuDidManagerSelected");
}

- (void)menuSelectedIndex:(NSUInteger)index {
    CGRect visibleRect = CGRectMake(index * CGRectGetWidth(self.scrollView.bounds), 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.scrollView scrollRectToVisible:visibleRect animated:NO];
    } completion:^(BOOL finished) {
        self.shouldObserving = YES;
    }];
}

#pragma mark - ScrollView delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{    //拖动前的起始坐标
    if (scrollView.tag == 999) {
        startX = scrollView.contentOffset.x;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 999) {
        endX = scrollView.contentOffset.x;
        if (startX != endX) {
            //每页宽度
            CGFloat pageWidth = scrollView.frame.size.width;
            //根据当前的坐标与页宽计算当前页码
            int currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
            [self.scrollMenu setSelectedIndex:currentPage animated:YES calledDelegate:NO];
            
            if ([[dataSourceArray objectAtIndex:self.scrollMenu.selectedIndex] count] == 0) {
                [self loadTopPicNewsList];
            }
        }
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"] && self.shouldObserving) {
        //每页宽度
        CGFloat pageWidth = self.scrollView.frame.size.width;
        //根据当前的坐标与页宽计算当前页码
        NSUInteger currentPage = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        if (currentPage > self.menus.count - 1)
            currentPage = self.menus.count - 1;
        
        CGFloat oldX = currentPage * CGRectGetWidth(self.scrollView.frame);
        if (oldX != self.scrollView.contentOffset.x) {
            BOOL scrollingTowards = (self.scrollView.contentOffset.x > oldX);
            NSInteger targetIndex = (scrollingTowards) ? currentPage + 1 : currentPage - 1;
            if (targetIndex >= 0 && targetIndex < self.menus.count) {
                CGFloat ratio = (self.scrollView.contentOffset.x - oldX) / CGRectGetWidth(self.scrollView.frame);
                CGRect previousMenuButtonRect = [self.scrollMenu rectForSelectedItemAtIndex:currentPage];
                CGRect nextMenuButtonRect = [self.scrollMenu rectForSelectedItemAtIndex:targetIndex];
                CGFloat previousItemPageIndicatorX = previousMenuButtonRect.origin.x;
                CGFloat nextItemPageIndicatorX = nextMenuButtonRect.origin.x;
                
                /* this bug for Memory
                 UIButton *previosSelectedItem = [self.scrollMenu menuButtonAtIndex:currentPage];
                 UIButton *nextSelectedItem = [self.scrollMenu menuButtonAtIndex:targetIndex];
                 [previosSelectedItem setTitleColor:[UIColor colorWithWhite:0.6 + 0.4 * (1 - fabsf(ratio))
                 alpha:1.] forState:UIControlStateNormal];
                 [nextSelectedItem setTitleColor:[UIColor colorWithWhite:0.6 + 0.4 * fabsf(ratio)
                 alpha:1.] forState:UIControlStateNormal];
                 */
                CGRect indicatorViewFrame = self.scrollMenu.indicatorView.frame;
                
                if (scrollingTowards) {
                    indicatorViewFrame.size.width = CGRectGetWidth(previousMenuButtonRect) + (CGRectGetWidth(nextMenuButtonRect) - CGRectGetWidth(previousMenuButtonRect)) * ratio;
                    indicatorViewFrame.origin.x = previousItemPageIndicatorX + (nextItemPageIndicatorX - previousItemPageIndicatorX) * ratio;
                } else {
                    indicatorViewFrame.size.width = CGRectGetWidth(previousMenuButtonRect) - (CGRectGetWidth(nextMenuButtonRect) - CGRectGetWidth(previousMenuButtonRect)) * ratio;
                    indicatorViewFrame.origin.x = previousItemPageIndicatorX - (nextItemPageIndicatorX - previousItemPageIndicatorX) * ratio;
                }
                self.scrollMenu.indicatorView.frame = indicatorViewFrame;
            }
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([dataSourceArray count] > self.scrollMenu.selectedIndex) {
        int count = (int)[[dataSourceArray objectAtIndex:self.scrollMenu.selectedIndex] count];
        return count;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 190;
    }else{
        return 82;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(0==[indexPath row]){//图片新闻第一个单元格，滑动图片，初始化TableCell3
        static NSString *CellIdentifier = @"firstcell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        if ([dataSourceArray count] > self.scrollMenu.selectedIndex) {
            NSArray *array = [dataSourceArray objectAtIndex:self.scrollMenu.selectedIndex];
            
            if ([array count] > 0) {
                UIView *obj =  [[dataSourceArray objectAtIndex:self.scrollMenu.selectedIndex] objectAtIndex:0];
                if (obj != nil) {
                    [cell.contentView addSubview:obj];
                }
            }
        }
        return cell;
    }else{
        
        static NSString *cellreuseIdentifier = @"NewsTableViewCell";
        NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellreuseIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:self options:nil] lastObject];
        }
        if ([[dataSourceArray objectAtIndex:self.scrollMenu.selectedIndex] count] > indexPath.row) {
            NSDictionary *info = [[dataSourceArray objectAtIndex:self.scrollMenu.selectedIndex] objectAtIndex:indexPath.row];
            //    NSString *newsid = [info objectForKey:@"id"];
            //    NSString *newsdate = [info objectForKey:@"newspath"];
            NSNumber *plnum = [info objectForKey:@"plnum"];
            NSString *smalltext = [info objectForKey:@"smalltext"];
            NSString *title = [info objectForKey:@"title"];
            NSString *titlepic = [info objectForKey:@"titlepic"];
            //        cell.newsimageurl = [NSString stringWithFormat:@"%@%@",API_HOST,titlepic];
            cell.newstitle.text = title;
            cell.newscontent.text = [NSString replaceHtmlTag:smalltext];
            cell.newsreplynum.text = [NSString stringWithFormat:@"%d",[plnum intValue]];
            [cell.newsimage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_HOST,titlepic]] placeholderImage:[UIImage imageNamed:@"defalut_pic"]];
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row != 0) {
        NSDictionary *info = [[dataSourceArray objectAtIndex:self.scrollMenu.selectedIndex] objectAtIndex:indexPath.row];
        NSString *newsid = [info objectForKey:@"id"];
        NSString *title = [info objectForKey:@"title"];
        NSString *titlepic = [info objectForKey:@"titlepic"];
        XHMenu *menu =  [self.menus objectAtIndex:self.scrollMenu.selectedIndex];
        NewsDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsDetailViewController"];
        vc.url = [NSString stringWithFormat:@"%@%@?dealType=%@&classid=%@&newid=%@",API_HOST,API_GET_NEWS_INFO,@"select",menu.menuid,newsid];
        vc.title = self.detailTitle;
        vc.newsid = newsid;
        vc.shareText = title;
        vc.classid = menu.menuid;
        vc.shareImage = [NSString stringWithFormat:@"%@%@",API_HOST,titlepic];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)buttonClick:(NSInteger)vid
{
    NewsTableViewCell *cell = [[toppicnewsArray objectAtIndex:self.scrollMenu.selectedIndex] objectAtIndex:vid - 1];
    NSString *newsid = cell.newsid;
    NSString *title = cell.title;
    NSString *titlepic = cell.titlepic;
    XHMenu *menu =  [self.menus objectAtIndex:self.scrollMenu.selectedIndex];
    NewsDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsDetailViewController"];
    vc.url = [NSString stringWithFormat:@"%@%@?dealType=%@&classid=%@&newid=%@",API_HOST,API_GET_NEWS_INFO,@"select",menu.menuid,newsid];
    vc.title = self.detailTitle;
    vc.newsid = newsid;
    vc.shareText = title;
    vc.classid = menu.menuid;
    vc.shareImage = [NSString stringWithFormat:@"%@%@",API_HOST,titlepic];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark UIScrollView PullDelegate

- (void)scrollView:(UIScrollView*)scrollView loadWithState:(LoadState)state {
    if (state == PullDownLoadState) {
        [self performSelector:@selector(PullDownLoadEnd) withObject:nil afterDelay:1];
    }
    else {
        [self performSelector:@selector(PullUpLoadEnd) withObject:nil afterDelay:1];
    }
}
//下拉刷新
- (void)PullDownLoadEnd {
    [self loadNewsList];
//    _tableView.canPullUp = YES;
}

- (void)PullUpLoadEnd {
//    page = [NSNumber numberWithInt:[page intValue] + PAGE_COUNT];
//    [self loadMore];
}

//- (void)leftMenu {
//    XDKAirMenuController *menu = [XDKAirMenuController sharedMenu];
//    
//    if (menu.isMenuOpened)
//        [menu closeMenuAnimated];
//    else
//        [menu openMenuAnimated];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
