//
//  NSObject+HKKVO.m
//  runTime
//
//  Created by globalwings  on 2018/11/16.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "NSObject+HKKVO.h"
#import <objc/runtime.h>
@implementation NSObject (HKKVO)
-(void)HK_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    //1. 动态生成一个类
    NSString *oldClassName = NSStringFromClass([self class]);
    NSString *newClassName = [@"HKKVO" stringByAppendingString:oldClassName];
    Class class = objc_allocateClassPair([self class], newClassName.UTF8String, 0);
//    IMP setName = [self methodForSelector:@selector(setName:)];
    class_addMethod(class, @selector(setName:), (IMP)setName, "v@:@");
    //注册类
    objc_registerProtocol(class);
    //修改被观察者的isa指针
    object_setClass(self, class);
}
void setName(id self, SEL _cmd, NSString *str){
    NSLog(@"来了%@", str);
}
@end
