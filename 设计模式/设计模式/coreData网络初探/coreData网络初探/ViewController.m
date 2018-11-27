//
//  ViewController.m
//  coreData网络初探
//
//  Created by globalwings  on 2018/11/27.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "ViewController.h"

#import <CoreData/CoreData.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1. 创建模型文件
    //2. 创建实体类
    //3. 生成上下文, 关联模型文件生成的数据库
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSMainQueueConcurrencyType];
    //持久化存储协调器 : 调度器
    //将数据从内存搞到硬盘
    //model模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator * store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    //路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [doc stringByAppendingPathComponent:@"company.db"];
    
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL URLWithString:sqlPath] options:nil error:nil];
    
    context.persistentStoreCoordinator = store;
}


@end
