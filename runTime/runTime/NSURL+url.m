//
//  NSURL+url.m
//  runTime
//
//  Created by globalwings  on 2018/11/16.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "NSURL+url.h"
#import <objc/runtime.h>
@implementation NSURL (url)
+(void)load{
    
    //1. 获取method
    Method urlWithStr = class_getClassMethod([NSURL class], @selector(URLWithString:));
    //2. 获取另外的method
    Method hk_method = class_getClassMethod([NSURL class], @selector(HK_URLWithString:));
    method_exchangeImplementations(urlWithStr, hk_method);
}
+(instancetype)HK_URLWithString:(NSString *)str{
    NSURL *url = [NSURL HK_URLWithString:str];
    if (url == nil) {
        NSLog(@"空的");
    }
    return url;
}
@end
