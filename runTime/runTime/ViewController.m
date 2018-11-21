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
@interface ViewController ()

@property(nonatomic, strong) Person *p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self foo];
    [ViewController instance];
    void (^foo)() = ^{
        
    };
    foo;
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
