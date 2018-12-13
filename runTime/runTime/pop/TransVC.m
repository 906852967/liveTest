//
//  TransVC.m
//  runTime
//
//  Created by globalwings  on 2018/12/10.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "TransVC.h"

/**
 动画效果
 */
typedef NS_ENUM(NSUInteger, MCTransitonAnimType) {
    MCTransitonAnimTypeFade = 0,    //渐变，效果不明显
    MCTransitonAnimTypeMoveIn,      //新的移入
    MCTransitonAnimTypeReveal,      //旧的移出
    MCTransitonAnimTypePush,         //推入,新的推入旧的推出
    MCTransitonAnimTypePageCurl,    // 向上翻一页
    MCTransitonAnimTypePageUnCurl,  // 向下翻一页
    MCTransitonAnimTypeRippleEffect,// 波纹
    MCTransitonAnimTypeSuckEffect,  // 像一块布被抽走
    MCTransitonAnimTypeCube,        // 立方体
    MCTransitonAnimTypeOglFlip,     // 平面反转
    MCTransitonAnimTypeCameraIrisHollowOpen, //摄像机开
    MCTransitonAnimTypeCameraIrisHollowClose //摄像机关
    
};

/**
 动画方向
 */
typedef NS_ENUM(NSUInteger, MCTransitonAnimDirection) {
    MCTransitonAnimDirectionFromLeft,
    MCTransitonAnimDirectionFromRight,
    MCTransitonAnimDirectionFromTop,
    MCTransitonAnimDirectionFromBottom
};

/**
 动画的速度变化
 */
typedef NS_ENUM(NSUInteger, MCTransitonAnimTimingFunc) {
    MCTransitonAnimTimingFuncLinear,      //线性
    MCTransitonAnimTimingFuncEaseIn,      //慢入
    MCTransitonAnimTimingFuncEaseOut,     //慢出
    MCTransitonAnimTimingFuncEaseInEaseOut//慢入慢出
};
@interface TransVC ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;
@end

@implementation TransVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.button];
    //CGD测试
    //[self GCDTest];
    //
    //[self communication];
    //测试异步同步执行
    //[self asynQueueSyn];
    //after
    //[self after];
    //groupNotify
    [self groupNotify];
    
}
- (UIButton *)button{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor orangeColor];
        _button.frame = CGRectMake(100, 400, 100, 50);
        [_button addTarget:self action:@selector(transButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
- (void)transButton{
    _button.hidden = YES;
    
    CATransition *trans = [self setTransitionAnimationWithType:MCTransitonAnimTypeRippleEffect duration:1.0f direction:MCTransitonAnimDirectionFromLeft timingFunc:MCTransitonAnimTimingFuncLinear];
    [self.imageView.layer addAnimation:trans forKey:@"trans"];
    _button.hidden = NO;
}
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(100, 100, 300, 200);
        _imageView.image = [UIImage imageNamed:@"999.jpg"];
        [self.view addSubview:_imageView];
    }
    return _imageView;
}
#pragma GCD
- (void)GCDTest
{
    //DISPATCH_QUEUE_SERIAL 表示串行队列，DISPATCH_QUEUE_CONCURRENT表示并发队列
    dispatch_queue_t queue = dispatch_queue_create("myGCD", DISPATCH_QUEUE_CONCURRENT);
    //主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //全局并发队列  第一个参数表示队列优先级，一般用DISPATCH_QUEUE_PRIORITY_DEFAULT。第二个参数暂时没用，用0即可
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSLog(@"主线程：%@",[NSThread currentThread]);
    dispatch_queue_t queueOne = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queueOne, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1====%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_async(queueOne, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2====%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    NSLog(@"执行任务1");
    dispatch_sync(globalQueue, ^{
        NSLog(@"执行任务2");
    });
    NSLog(@"执行任务3");
}
- (void)communication {
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        // 异步追加任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
        
        // 回到主线程
        dispatch_async(mainQueue, ^{
            // 追加在主线程中执行的任务
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        });
    });
}
//异步情况同步操作
- (void)asynQueueSyn
{
    dispatch_queue_t queue = dispatch_queue_create("rw_queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 5; i++) {
        [self read:queue];
        [self write:queue];
        [self look:queue];
    }
}
- (void)read:(dispatch_queue_t)queue
{
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"read===1");
    });
}
- (void)write:(dispatch_queue_t)queue
{
    dispatch_barrier_async(queue, ^{
        sleep(1);
        NSLog(@"write===2");
    });
}
- (void)look:(dispatch_queue_t)queue
{
    dispatch_barrier_async(queue, ^{
        sleep(1);
        NSLog(@"look===3");
    });
}
//GCD 延时执行方法：dispatch_after
- (void)after
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncMain---begin");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2.0秒后异步追加任务代码到主队列，并开始执行
        NSLog(@"after---%@",[NSThread currentThread]);  // 打印当前线程
    });
}
/**
 * 队列组 dispatch_group_notify
 */
- (void)groupNotify
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
        
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步任务1、任务2都执行完毕后，回到主线程执行下边任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
        NSLog(@"group---end");
    });
}
- (CATransition *)setTransitionAnimationWithType:(MCTransitonAnimType)animType
                              duration:(float)duration
                             direction:(MCTransitonAnimDirection)subtype
                            timingFunc:(MCTransitonAnimTimingFunc)timingFunc
{
    CATransition *trans = [CATransition animation];
    trans.duration = duration;
    // 动画种类
    switch (animType) {
        case MCTransitonAnimTypeFade://渐变，效果不明显
            trans.type = kCATransitionFade;
            break;
        case MCTransitonAnimTypeMoveIn://新的移入
            trans.type = kCATransitionMoveIn;
            break;
        case MCTransitonAnimTypeReveal://旧的移出
            trans.type = kCATransitionReveal;
            break;
        case MCTransitonAnimTypePush://推入,新的推入旧的推出
            trans.type = kCATransitionPush;
            break;
        case MCTransitonAnimTypePageCurl:// 向上翻一页
            trans.type = @"pageCurl";
            break;
        case MCTransitonAnimTypePageUnCurl:// 向下翻一页
            trans.type = @"pageUnCurl";
            break;
        case MCTransitonAnimTypeRippleEffect:// 波纹
            trans.type = @"rippleEffect";
            break;
        case MCTransitonAnimTypeSuckEffect:// 像一块布被抽走
            trans.type = @"suckEffect";
            break;
        case MCTransitonAnimTypeCube:// 立方体
            trans.type = @"cube";
            break;
        case MCTransitonAnimTypeOglFlip:// 平面反转
            trans.type = @"oglFlip";
            break;
        case MCTransitonAnimTypeCameraIrisHollowOpen://摄像机开
            trans.type = @"cameraIrisHollowOpen";
            break;
        case MCTransitonAnimTypeCameraIrisHollowClose://摄像机关
            trans.type = @"cameraIrisHollowClose";
            break;
        default:
            break;
    }
    // 动画的速度变化
    switch (timingFunc) {
        case MCTransitonAnimTimingFuncLinear:
            trans.timingFunction =  [CAMediaTimingFunction functionWithName:@"linear"];
            break;
        case MCTransitonAnimTimingFuncEaseIn:
            trans.timingFunction =  [CAMediaTimingFunction functionWithName:@"easeIn"];
            break;
        case MCTransitonAnimTimingFuncEaseOut:
            trans.timingFunction =  [CAMediaTimingFunction functionWithName:@"easeOut"];
            break;
        case MCTransitonAnimTimingFuncEaseInEaseOut:
            trans.timingFunction =  [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
            break;
        default:
            break;
    }
    switch (subtype) {
        case MCTransitonAnimDirectionFromLeft:
            trans.subtype = kCATransitionFromLeft;
            break;
        case MCTransitonAnimDirectionFromRight:
            trans.subtype = kCATransitionFromRight;
            break;
        case MCTransitonAnimDirectionFromTop:
            trans.subtype = kCATransitionFromTop;
            break;
        case MCTransitonAnimDirectionFromBottom:
            trans.subtype = kCATransitionFromBottom;
            break;
        default:
            break;
    }
    return trans;
}
@end
