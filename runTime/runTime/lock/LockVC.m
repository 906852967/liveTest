//
//  LockVC.m
//  runTime
//
//  Created by globalwings  on 2018/12/5.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "LockVC.h"
#import "../Person.h"
@interface LockVC ()
@property (nonatomic, assign) NSInteger ticketsCount;
@property (nonatomic, strong) NSRecursiveLock *ticketLock;
@property (nonatomic, strong) NSCondition *condition;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) Person *person1;
@property (nonatomic, strong) Person *person2;
@end

@implementation LockVC

-(void)dealloc{
    [self.person1 removeObserver:self forKeyPath:@"name"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
//    [self ticketTest];
//    [self testData];
    [self kvoTest];
}
- (void)kvoTest{
    self.person1 = [[Person alloc] init];
    self.person2 = [[Person alloc] init];
    self.person1.name = @"dandan";
    self.person2.name = @"dieer";
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person1 addObserver:self forKeyPath:@"name" options:options context:@"zhangdandan"];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.person1.name = @"zhangdandan";
    self.person2.name = @"lidie";
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"监听到%@的%@属性值改变了 - %@ - %@", object, keyPath, change, context);
}

//卖票演示
- (void)ticketTest{
    self.ticketsCount = 50;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (NSInteger i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            for (int i = 0; i < 10; i++) {
                [self addLock];
            }
        });
    }
}
//卖票
- (void)sellingTickets{
    int oldMoney = self.ticketsCount;
    sleep(.2);
    oldMoney -= 1;
    self.ticketsCount = oldMoney;
    
}
//加🔒
- (void)addLock{
    [self.ticketLock lock];
    [self sellingTickets];
    [self.ticketLock unlock];
    NSLog(@"当前剩余票数-> %d", self.ticketsCount);
}
// 线程1
// 删除数组中的元素
- (void)remove:(NSInteger)count{
    [self.condition lock];
    if (self.data.count == 0) {
        [self.condition wait];
    }
    NSLog(@"删除了元素%ld", count);
    [self.data removeLastObject];
    [self.condition unlock];
}
// 线程2
// 往数组中添加元素
- (void)add:(NSInteger)count{
    [self.condition lock];
    sleep(1);
    [self.data addObject:@"Test"];
    NSLog(@"添加了元素%ld", count);
    // 信号
    [self.condition signal];
    [self.condition unlock];
}
- (void)testData{
    self.data = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        [self add:i];
        [self remove:i];
    }
}
@end
