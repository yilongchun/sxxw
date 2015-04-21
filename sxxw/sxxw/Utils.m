//
//  Util.m
//  hmjz
//
//  Created by yons on 14-10-23.
//  Copyright (c) 2014年 yons. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSMutableURLRequest *)postRequestWithParems:(NSURL *)url image: (UIImage *)image imageName: (NSString *)imagename
{
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60];
    //分割符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //http 参数body的字符串
    NSMutableString *paraBody=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    
    //添加分界线，换行
    [paraBody appendFormat:@"%@\r\n",MPboundary];
    //添加字段名称，换2行
    [paraBody appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"param"];
//    NSString *post=[NSString jsonStringWithDictionary:postParams];
    //添加字段的值
//    [paraBody appendFormat:@"%@\r\n",post];
    [paraBody appendFormat:@"\r\n"];
    
//    NSLog(@"参数%@ == %@",@"param",post);
    NSLog(@"%@",paraBody);
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData = [[NSMutableData alloc] init];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[paraBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSMutableString *imageBody = [[NSMutableString alloc] init];
    NSData *imageData = nil;
    NSString *fileName = nil;
    //判断图片是不是png格式的文件

    //返回为JPEG图像。
    imageData = UIImageJPEGRepresentation(image, 0.7);
    fileName = imagename;

    NSLog(@"%lu",(unsigned long)imageData.length);
    NSString *name = @"uploadedfile";
    
    //添加分界线，换行
    [imageBody appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [imageBody appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",name,fileName];
    //声明上传文件的格式
    [imageBody appendFormat:@"Content-Type: image/png,image/jpge,image/gif, image/jpeg, image/pjpeg, image/pjpeg\r\n\r\n"];
    //将image的data加入
    
    [myRequestData appendData:[imageBody dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData appendData:[[NSData alloc] initWithData:imageData]];
    [myRequestData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    return request;
}

@end
