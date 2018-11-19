//
//  MyThread.m
//  runloopTry
//
//  Created by globalwings  on 2018/11/14.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "MyThread.h"

@implementation MyThread
-(void)dealloc{
    NSLog(@"%@线程被释放了", self.name);
}
@end
