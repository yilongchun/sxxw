//
//  NSDictionary+Category.m
//  gamyt
//
//  Created by yons on 15-3-10.
//  Copyright (c) 2015年 hmzl. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)

+(NSDictionary *)cleanNullForDic:(NSDictionary *)dic{
    NSMutableDictionary *muDic=[[NSMutableDictionary alloc] initWithDictionary:dic];
    NSArray *allkeys=[muDic allKeys];
    NSArray *allValues=[muDic allValues];
    for (int i=0; i<allValues.count; i++) {
        id obj=allValues[i];
        if ([obj isKindOfClass:[NSNull class]]) {
            [muDic setObject:@"" forKey:allkeys[i]];
        }
    }
    return muDic;
}

@end
