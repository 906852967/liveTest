//
//  ViewController.m
//  runloopTry
//
//  Created by globalwings  on 2018/11/14.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "ViewController.h"
#import "MyThread.h"
#import "TestVC.h"
@interface ViewController ()
@property(nonatomic, weak) MyThread *myThread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 50, 100, 45);
    button.backgroundColor = [UIColor cyanColor];
    [button addTarget:self action:@selector(buttonTap) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
    NSLog(@"%@----开辟子线程", [NSThread currentThread]);
    
//     MyThread *myThread = [[MyThread alloc] initWithTarget:self selector:@selector(subThreadTodo) object:nil];
//    self.myThread = myThread;
//    self.myThread.name = @"subThread";
//    [self.myThread start];
    
    int lageer = 1024 * 1024 * 2 * 100;
//    for (int i = 0; i < lageer; i++) {
//
//            NSString *str = [NSString stringWithFormat:@"Hello"];
//            str = [str uppercaseString];
//            str = [NSString stringWithFormat:@"%@-%@",@"Hello", @"World!"];
//            NSLog(@"%@", str);
//
//    }
}
- (void)buttonTap{
    [self presentViewController:[[TestVC alloc] init] animated:YES completion:nil];
}
- (void)subThreadTodo{
    
    NSLog(@"%@----开始执行子线程任务",[NSThread currentThread]);
    //获取当前子线程的RunLoop
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    //
    [runloop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
    
    [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    
//    [runloop run];
    
    NSLog(@"%@----执行子线程任务结束",[NSThread currentThread]);
}
//我们希望放在子线程中执行的任务
- (void)wantTodo{
    //断点2
    NSLog(@"当前线程:%@执行任务处理数据", [NSThread currentThread]);
    
    //需要用while循环控制的RunLoop
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        while (!self.isBeingPresented) {
            [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantPast]];
        }
    }
    //不需要用while循环控制的RunLoop
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self performSelectorOnMainThread:@selector(wantTodo) withObject:nil waitUntilDone:NO];
}
@end
