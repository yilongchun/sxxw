//
//  TougaoViewController.m
//  sxxw
//
//  Created by yons on 15-4-16.
//  Copyright (c) 2015年 weiyida. All rights reserved.
//

#import "TougaoViewController.h"
#import "IQKeyboardManager.h"
#import "QCheckBox.h"
#import "TFHpple.h"
#import "Utils.h"

@interface TougaoViewController ()<QCheckBoxDelegate>

@end

@implementation TougaoViewController{
    QCheckBox *oldButton;
    
    NSString *imagenames;
    NSString *httpimagenames;
    NSString *typeid;
    NSMutableArray *chosenImages;
    
    int tempTag;
    UIView *tempImage;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.title = @"投稿反馈";
    
    chosenImages = [NSMutableArray array];
    
    
    [self initBtn];
    
//    QCheckBox *_check1 = [[QCheckBox alloc] initWithDelegate:self normal:[UIImage imageNamed:@"radio_checked"] selected:[UIImage imageNamed:@"radio_unchecked"]];
////    QCheckBox *_check1 = [[QCheckBox alloc] initWithDelegate:self];
//    _check1.tag = 1;
//    _check1.frame = CGRectMake(60, 5, 100, 30);
//    [_check1 setTitle:@"信息交流" forState:UIControlStateNormal];
//    [_check1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_check1.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
//    [_check1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//    [self.lanmu addSubview:_check1];
//    
//    QCheckBox *_check2 = [[QCheckBox alloc] initWithDelegate:self normal:[UIImage imageNamed:@"radio_checked"] selected:[UIImage imageNamed:@"radio_unchecked"]];
////    QCheckBox *_check2 = [[QCheckBox alloc] initWithDelegate:self];
//    _check2.tag = 2;
//    _check2.frame = CGRectMake(170, 5, 100, 30);
//    [_check2 setTitle:@"观点碰撞" forState:UIControlStateNormal];
//    [_check2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_check2.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
//    [_check2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//    [self.lanmu addSubview:_check2];
//    
//    QCheckBox *_check3 = [[QCheckBox alloc] initWithDelegate:self normal:[UIImage imageNamed:@"radio_checked"] selected:[UIImage imageNamed:@"radio_unchecked"]];
////    QCheckBox *_check3 = [[QCheckBox alloc] initWithDelegate:self];
//    _check3.tag = 3;
//    _check3.frame = CGRectMake(60, 45, 100, 30);
//    [_check3 setTitle:@"热点推荐" forState:UIControlStateNormal];
//    [_check3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_check3.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
//    [_check3 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//    [self.lanmu addSubview:_check3];
    
    self.lanmuLabel.textColor = [UIColor grayColor];
    [self.lanmu.layer setMasksToBounds:YES];
    [self.lanmu.layer setBorderWidth:0.6f];
    [self.lanmu.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"标题(*):";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor clearColor];
    self.titleText.leftViewMode = UITextFieldViewModeAlways;
    self.titleText.leftView = label;
    self.titleText.borderStyle=UITextBorderStyleNone;
    [self.titleText.layer setMasksToBounds:YES];
    [self.titleText.layer setBorderWidth:0.6f];
    [self.titleText.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"投稿人:";
    label2.textColor = [UIColor grayColor];
    label2.font = [UIFont systemFontOfSize:14];
    label2.backgroundColor = [UIColor clearColor];
    self.tougaouser.leftViewMode = UITextFieldViewModeAlways;
    self.tougaouser.leftView = label2;
    self.tougaouser.borderStyle=UITextBorderStyleNone;
    [self.tougaouser.layer setMasksToBounds:YES];
    [self.tougaouser.layer setBorderWidth:0.6f];
    [self.tougaouser.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.content.layer setMasksToBounds:YES];
    [self.content.layer setBorderWidth:0.6f];
    [self.content.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.myscrollview.contentOffset = self.scrollviewContentOffsetChange;
    self.myscrollview.contentSize = CGSizeMake(self.view.frame.size.width,CGRectGetMaxY(self.btn1.frame) + 10);
    if (chosenImages.count > 0) {
        CGFloat width = chosenImages.count * 90;
        if (chosenImages.count > 1) {
            width = width + (chosenImages.count - 1) * 5;
        }
        [self.imagescrollview setContentSize:CGSizeMake(width, 90)];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.myscrollview.contentOffset = CGPointZero;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.scrollviewContentOffsetChange = self.myscrollview.contentOffset;
}

-(void)initBtn{
    [self showHudInView:self.view hint:@"加载中"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"select" forKey:@"dealType"];
    [parameters setValue:[NSNumber numberWithInt:4] forKey:@"bclassid"];
    
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
                NSString *classname = [info objectForKey:@"classname"];
                QCheckBox *_check1 = [[QCheckBox alloc] initWithDelegate:self normal:[UIImage imageNamed:@"radio_checked"] selected:[UIImage imageNamed:@"radio_unchecked"]];
                _check1.btnid = classid;
                _check1.tag = i + 1;
                _check1.frame = CGRectMake((i % 2) * 110 + 60, (i / 2 * 40) + 5, 100, 30);
                [_check1 setTitle:classname forState:UIControlStateNormal];
                [_check1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_check1.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
                [_check1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [self.lanmu addSubview:_check1];
            }
        }
        [self hideHud];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [self hideHud];
        [self showHint:@"连接失败"];
    }];
}

-(void)click:(QCheckBox *)button{
    if (button.tag != oldButton.tag) {
        [oldButton setChecked:NO];
    }
    if ([button checked]) {
        oldButton = button;
        typeid = button.btnid;
    }else{
        oldButton = nil;
        typeid = @"";
    }
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

- (IBAction)takePicture:(id)sender {
    NSLog(@"takePicture");
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"sorry, no camera or camera is unavailable.");
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects:@"public.image", nil];
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (IBAction)choosePicture:(id)sender {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 100; //Set the maximum number of images to select to 100
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = NO; //For multiple image selection, display and return order of selected images
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage]; //Supports image and movie types
    elcPicker.imagePickerDelegate = self;
    [self presentViewController:elcPicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        UIImage  *image = [info objectForKey:UIImagePickerControllerEditedImage];
        [chosenImages addObject:image];
        [self addImageToImageScrollView];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [chosenImages addObject:image];
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        }  else {
            NSLog(@"Uknown asset type");
        }
    }
    [self addImageToImageScrollView];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tapImage:(UITapGestureRecognizer *)gesture{
    UIMenuController *popMenu = [UIMenuController sharedMenuController];
    UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(menuItem1Pressed:)];
    NSArray *menuItems = [NSArray arrayWithObjects:item1,nil];
    [popMenu setMenuItems:menuItems];
    [popMenu setArrowDirection:UIMenuControllerArrowDown];
    [popMenu setTargetRect:CGRectMake(45,0,0,0) inView:gesture.view];
    [popMenu setMenuVisible:YES animated:YES];
    tempTag = (int)gesture.view.tag;
    tempImage = gesture.view;
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(BOOL) canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(menuItem1Pressed:)) {
        return YES;
    }
    return NO; //隐藏系统默认的菜单项
}

- (void)menuItem1Pressed:(UIMenuItem *)sender{
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    if (tempImage) {
        [tempImage removeFromSuperview];
        [chosenImages removeObjectAtIndex:tempTag - 1];
    }
    [self addImageToImageScrollView];
}

-(void)addImageToImageScrollView{
    for (UIImageView *imgview in self.imagescrollview.subviews) {
        [imgview removeFromSuperview];
    }
    [chosenImages enumerateObjectsUsingBlock:^(UIImage *obj, NSUInteger idx, BOOL *stop) {
        CGFloat x = idx * (5 + 90);
        UIImageView *imageview = [[UIImageView alloc] initWithImage:obj];
        imageview.frame = CGRectMake(x, 0, 90, 90);
        imageview.userInteractionEnabled = YES;
        imageview.tag = idx + 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        [imageview addGestureRecognizer:tap];
        [self.imagescrollview addSubview:imageview];
    }];
    
    if (chosenImages.count > 0) {
        CGFloat width = chosenImages.count * 90;
        if (chosenImages.count > 1) {
            width = width + (chosenImages.count - 1) * 5;
        }
        [self.imagescrollview setContentSize:CGSizeMake(width, 90)];
        self.imagescrollviewLayoutConstraint.constant = 90;
    }else{
        self.imagescrollviewLayoutConstraint.constant = 0;
    }
    
    NSLog(@"%@",chosenImages);
}

- (IBAction)save:(id)sender {
    NSLog(@"save");
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
    
    if ([self.titleText.text isEqualToString:@""]) {
        [self showHint:@"标题不能为空！"];
        return;
    }
    if ([self.content.text isEqualToString:@""]) {
        [self showHint:@"稿件内容不能为空！"];
        return;
    }
    if ([typeid isEqualToString:@""]) {
        [self showHint:@"请选择栏目！"];
        return;
    }
    
    
    [self showHudInView:self.view hint:@"正在上传，请稍后......"];
    
    __block int total = 0;
    NSMutableArray *fileNamesArray = [NSMutableArray array];
    for (UIImage *image in chosenImages) {
        UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000*1000;
        [fileNamesArray addObject:[NSString stringWithFormat:@"%llu.jpg",recordTime]];
        NSMutableURLRequest *request = [Utils postRequestWithParems:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_HOST,API_UPLOAD_IMAGE_URL]] image:image imageName:[NSString stringWithFormat:@"%llu.jpg",recordTime]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *html = operation.responseString;
            total++;
            NSLog(@"response %@ %d",html,total);
            
            if (total == chosenImages.count) {
                [self saveData:fileNamesArray];
            }
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"发生错误！%@",error);
            [self hideHud];
            [self showHint:@"上传失败"];
        }];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue addOperation:operation];
    }
}

-(void)saveData:(NSArray *)fileNamesArray{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *fbt = @"";
    NSString *guanjianzi = @"";
    NSString *jianjie = @"";
    NSString *zuozhe = self.tougaouser.text;
    NSMutableString *ownernews = [NSMutableString stringWithString:self.content.text];
    if(fileNamesArray.count > 0){
        for(int i=0;i<fileNamesArray.count;i++){
            [ownernews appendFormat:@"</br></br><img src='%@/cm/e/uploadPic/%@' />",API_HOST, fileNamesArray[i]];
        }
    }
    NSMutableString *temp  = [NSMutableString string];
    if(![zuozhe isEqualToString:@""]){
        [temp appendFormat:@"<center>投稿人：%@</center>&nbsp;&nbsp;&nbsp;&nbsp;",zuozhe];
    }
    
    [parameters setValue:@"MAddInfo" forKey:@"enews"];
    [parameters setValue:@"1418027821" forKey:@"filepass"];
    [parameters setValue:typeid forKey:@"classid"];
    [parameters setValue:[NSString stringWithFormat:@"%@%@",temp,ownernews] forKey:@"newstext"];
    [parameters setValue:@"1" forKey:@"mid"];
    [parameters setValue:self.titleText.text forKey:@"title"];
    [parameters setValue:fbt forKey:@"ftitle"];
    [parameters setValue:guanjianzi forKey:@"keyboard"];
    [parameters setValue:jianjie forKey:@"smalltext"];
    [parameters setValue:zuozhe forKey:@"writer"];
    [parameters setValue:@"" forKey:@"befrom"];
    
    NSString *str = [NSString stringWithFormat:@"%@%@",API_HOST,API_TO_OWNERNEWS_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager POST:str parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [NSString stringWithFormat:@"%@",[operation responseString]];
        NSLog(@"%@",result);
        [self hideHud];
        if ([result isEqualToString:@"1"]) {
            [self showHint:@"投稿成功"];
            [self performSelector:@selector(back) withObject:nil afterDelay:1.5];
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
        [self showHint:@"投稿失败"];
    }];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
