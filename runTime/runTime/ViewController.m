//
//  ViewController.m
//  runTime
//
//  Created by globalwings  on 2018/11/15.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>
#import "NSObject+HKKVO.h"
#import <os/lock.h>
#import <pthread.h>
#import "present/TestVC.h"
#import "present/TransformVC.h"
#import "pop/PopVC.h"
#import "lock/LockVC.h"
#import "pop/TransVC.h"
@interface ViewController ()

typedef NS_ENUM(NSInteger,AnimationType) {
    kAnimationTypeFade,                         //淡入淡出
    kAnimationTypeMoveIn,                       //覆盖
    kAnimationTypePush,                         //推挤
    kAnimationTypeReveal,                       //揭开
    kAnimationTypeCube,                         //3D立方体
    kAnimationTypeSuckEffect,                   //吮吸
    kAnimationTypeOglFlip,                      //翻转
    kAnimationTypeRippleEffect,                 //波纹
    kAnimationTypePageCurl,                     //翻页
    kAnimationTypePageUnCurl,                   //反翻页
    kAnimationTypeCameraIrisHollowOpen,         //开镜头
    kAnimationTypeCameraIrisHollowClose,        //关镜头
    kAnimationTypeCurlDown,                     //下翻页
    kAnimationTypeCurlUp,                       //上翻页
    kAnimationTypeFlipFromLeft,                 //左翻转
    kAnimationTypeFlipFromRight                 //右翻转
};
@property(nonatomic, strong) Person *p;
@property (nonatomic, assign) NSInteger ticketsCount;
@property (nonatomic, assign) os_unfair_lock ticketLock;  //自旋🔒
@property (nonatomic, assign) pthread_mutex_t ticketMutex;  //互斥🔒
@end

@implementation ViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        //自动🔒
//        self.ticketLock = OS_UNFAIR_LOCK_INIT;
        // 初始化属性
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        // 初始化锁
        pthread_mutex_init(&(_ticketMutex), &attr);
        // 销毁属性
        pthread_mutexattr_destroy(&attr);
    }
    return self;
}
- (void)pushVC:(UIButton *)button{
    [self transitionWithType:@"pageCurl" subtype:nil];
//    [self presentViewController:[[TestVC alloc] init] animated:YES completion:nil];
}
- (void)popVC:(UIButton *)button{
    PopVC *popvc = [[PopVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:popvc];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)lockVC:(UIButton *)button{
    LockVC *lockvc = [[LockVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lockvc];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark - CATransition
- (void)transitionWithType:(NSString *)type subtype:(NSString *)subtype{
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.7f;
//    animation.type = type;
//    if (subtype) {
//        animation.subtype = subtype;
//    }
//    //动画速度
//    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
//    [self.view.layer addAnimation:animation forKey:@"animation"];
    [self presentViewController:[[TransformVC alloc] init] animated:YES completion:nil];
}
#pragma mark - UIView
- (void)animationWithTransition:(UIViewAnimationTransition)transition{
    [UIView animateWithDuration:0.7f animations:^{
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];5
//        TestVC *test = [[TestVC alloc]init];
//        [UIView setAnimationTransition:transition forView:test.view cache:YES];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(100, 100, 100, 100);
    _button.backgroundColor = [UIColor cyanColor];
    [_button addTarget:self action:@selector(pushVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secondButton.frame = CGRectMake(100, 300, 100, 100);
    secondButton.backgroundColor = [UIColor yellowColor];
    [secondButton addTarget:self action:@selector(popVC:) forControlEvents:UIControlEventTouchDown];
    [secondButton addTarget:self action:@selector(popVC:) forControlEvents:UIControlEventTouchUpInside];
    [secondButton addTarget:self action:@selector(popVC:) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:secondButton];
    
    UIButton *lockButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lockButton.frame = CGRectMake(100, 500, 100, 100);
    lockButton.backgroundColor = [UIColor purpleColor];
    [lockButton setTitle:@"🔒" forState:UIControlStateNormal];
    [lockButton addTarget:self action:@selector(lockVC:) forControlEvents:UIControlEventTouchDown];
    [lockButton addTarget:self action:@selector(lockVC:) forControlEvents:UIControlEventTouchUpInside];
    [lockButton addTarget:self action:@selector(lockVC:) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:lockButton];
    
    UIButton *transButton = [UIButton buttonWithType:UIButtonTypeCustom];
      transButton.frame = CGRectMake(100, 700, 100, 100);
    transButton.backgroundColor = [UIColor yellowColor];
    [transButton addTarget:self action:@selector(transVC) forControlEvents:UIControlEventTouchDown];
    [transButton addTarget:self action:@selector(transVC) forControlEvents:UIControlEventTouchUpInside];
    [transButton addTarget:self action:@selector(transVC) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:transButton];
    
    
    [self ticketTest];
    [self foo];
    [ViewController instance];
    void (^foo)() = ^{
        
    };
    foo;
}
//卖票演示
- (void)ticketTest{
    self.ticketsCount = 50;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (NSInteger i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            for (int i = 0; i < 10; i++) {
                [self addPthread];
            }
        });
    }
}
//加锁函数
- (void)addPthread{
    //自动🔒
    
    //os_unfair_lock_lock(&_ticketLock);
    
    //互斥🔒
    pthread_mutex_lock(&_ticketMutex);
    [self sellingTickets];
    //互斥解锁
    pthread_mutex_unlock(&_ticketMutex);
    //自动解锁
     // os_unfair_lock_unlock(&_ticketLock);
}
//卖票
- (void)sellingTickets{
    int oldMoney = self.ticketsCount;
    sleep(.2);
    oldMoney -= 1;
    self.ticketsCount = oldMoney;
    //NSLog(@"当前剩余票数-> %d", oldMoney);
}
-runtimePerson{
    Person *p = [[Person alloc] init];
    //监听name属性
    [p HK_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    _p = p;
    
    //[p eat];
    //调用对象方法
    //    [p performSelector:@selector(eat)];
    
    NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
    NSLog(@"%@", url);
    
    //给p对象发送eat消息
    //objc_msgSend(p, @selector(eat));
    return nil;
}
-(void)transVC{
    TransVC *transvc = [[TransVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:transvc];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@", _p.name);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    static int i = 0;
    i++;
    _p.name = [NSString stringWithFormat:@"%d", i];
}


-foo{
    return nil;
}
+ instance{
    return nil;
}
@end
