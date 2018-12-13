//
//  NSOperationVC.m
//  runTime
//
//  Created by globalwings  on 2018/12/13.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "NSOperationVC.h"

@interface NSOperationVC ()

@end

@implementation NSOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    //[self Operation1];
    //[self Operation2];
    [self Operation6];
}
- (void)setUI
{
    self.view.backgroundColor = [UIColor cyanColor];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)Operation1
{
    //1. 创建NSInvocationOperation对象
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(test) object:nil];
    //2. 开始调用
    [op start];
}
- (void)Operation2
{
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"当前线程:%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"当前线程2：%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"当前线程3：%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"当前线程4：%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op start];
    
}
- (void)Operation4{
    //1、创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    //2、创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"当前线程1:%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"当前线程2:%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"当前线程3:%@",[NSThread currentThread]);
    }];
    
    //3、添加操作
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}
- (void)Operation5{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperationWithBlock:^{
        NSLog(@"当前线程1:%@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"当前线程2:%@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"当前线程3:%@",[NSThread currentThread]);
    }];
}
- (void)Operation6{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [self getTime];
    //创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"当前线程1:%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"当前线程2:%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"当前线程3:%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"当前线程4:%@",[NSThread currentThread]);
        [self getTime];
    }];
    //3. 添加依赖
//    [op4 addDependency:op1];
//    [op4 addDependency:op3];
//    [op4 addDependency:op2];
    //设置优先级
    op1.queuePriority = 8;
    op2.queuePriority = 0;
    op3.queuePriority = -4;
    op4.queuePriority = -8;
    //4. 添加操作
    [queue addOperation:op3];
    [queue addOperation:op2];
    [queue addOperation:op1];
    [queue addOperation:op4];
    
}
- (void)getTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *nowtimeStr = [formatter stringFromDate:datenow];
    
    NSLog(@"nowtimeStr =  %@",nowtimeStr);
}
- (void)test
{
    for (NSInteger i = 0; i < 2; i++) {
        NSLog(@"当前线程:%@", [NSThread currentThread]);
    }
}
@end
