//
//  TestVC.m
//  runloopTry
//
//  Created by globalwings  on 2018/11/14.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "TestVC.h"
#import "MyThread.h"
@interface TestVC ()<UIScrollViewDelegate>
@property (nonatomic, weak) NSThread *subThread;  //子线程
@property (nonatomic, weak) NSRunLoopMode runLoopModel; //想设置的runLoopModel
@property (nonatomic, assign) BOOL isNeedRunStop; //控制是否需要停止
@property (nonatomic, strong) UITextView *myTextView;

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    _myTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, 50, 250, 400)];
    _myTextView.text = @"aaaaaaaaaa";
    [self.view addSubview:_myTextView];
    
    self.myTextView.delegate = self;
    self.isNeedRunStop = NO;
    NSLog(@"%@----开辟子线程",[NSThread currentThread]);

    NSThread *tmpThread = [[MyThread alloc] initWithTarget:self selector:@selector(subThreadTodo) object:nil];
    self.subThread = tmpThread;
    self.subThread.name = @"subThread";
    [self.subThread start];
}
- (void)subThreadTodo{
    NSLog(@"%@----开始执行子线程任务",[NSThread currentThread]);
    
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerTodo) userInfo:nil repeats:YES];
        //给UITrackingRunLoopMode添加一个timer，为了等下切换到该模式的时候能看到效果。
        //提示：子线程RunLoop如果不给UITrackingRunLoopMode添加item就没有这个Mode，可以看前面初体验疑问的截图。
        //但是，NSDefaultRunLoopMode是无论如何都存在的，就算你不给他添加item，他也只是内容为空而已。
        [runLoop addTimer:timer forMode:UITrackingRunLoopMode];
        
        self.runLoopModel = NSDefaultRunLoopMode;
        //这一句先保持注释状态，之后再根据下面文章的提示取消注释看效果。
        //CFRunLoopAddCommonMode(CFRunLoopGetCurrent(), (CFStringRef)UITrackingRunLoopMode);
        while (!self.isNeedRunStop) {
            [runLoop runMode:self.runLoopModel beforeDate:[NSDate distantFuture]];
        }
    }
}
- (void)changeSubThreadRunLoopMode:(NSRunLoopMode)mode{
    //改变我们希望RunLoop运行的Mode的方法
    //到时候用[performSelector:onThread:withObject:waitUntilDone:]来调用
    //结合[runMode:beforeDate:]触发非Timer的事件源会退出RunLoop的特性
    //再结合上面While的写法，就退出了之前的RunLoop并让RunLoop以我们希望的Mode重新Run。
    
    //断点3
    NSLog(@"当前线程:%@ RunLoop即将将Mode改变成:%@\n", [NSThread currentThread], mode);
    self.runLoopModel = mode;
}
- (void)timeTodo{
    //上面的Timer执行的函数，只是为了等下切换的mode后有打印好观察。
    NSLog(@"Timer启动啦，当前RunLoopMode:%@\n", [[NSRunLoop currentRunLoop] currentMode]);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.runLoopModel != UITrackingRunLoopMode) {
        //如果有滑动事件，并且RunLoop的Mode不为UITrackingRunLoopMode
        //就改变Mode并退出当前RunLoop然后让RunLoop以更改后的Mode重新Run
        //加if是为了避免重复操作，切换RunLoopMode只需要一次
        [self performSelector:@selector(changeSubThreadRunLoopMode:) onThread:self.subThread withObject:NSDefaultRunLoopMode waitUntilDone:NO];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        if(self.runLoopModel != NSDefaultRunLoopMode){
            [self performSelector:@selector(changeSubThreadRunLoopMode:) onThread:self.subThread withObject:NSDefaultRunLoopMode waitUntilDone:NO];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //拖拽后的后续滑动动画结束（如果有才会到这，没有就不会到这个函数里面）
    //也就是说上面那个函数如果切换了Mode就不会走这里，否则说明需要在这里切换Mode
    //切换Mode为NSDefaultRunLoopMode
    if (self.runLoopModel != NSDefaultRunLoopMode) {
        //断点2
        [self performSelector:@selector(changeSubThreadRunLoopMode:) onThread:self.subThread withObject:NSDefaultRunLoopMode waitUntilDone:NO];
    }
}
@end
