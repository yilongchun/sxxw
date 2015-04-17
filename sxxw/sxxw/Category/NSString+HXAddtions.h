//
//  NSString+HXAddtions.h
//  gamyt
//
//  Created by yons on 15-3-6.
//  Copyright (c) 2015年 hmzl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HXAddtions)

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;

+(NSString *) jsonStringWithArray:(NSArray *)array;

+(NSString *) jsonStringWithString:(NSString *) string;

+(NSString *) jsonStringWithObject:(id) object;

+(NSString *) replaceHtmlTag:(NSString *) string;

@end
