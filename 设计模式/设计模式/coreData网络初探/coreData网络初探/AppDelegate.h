//
//  AppDelegate.h
//  coreData网络初探
//
//  Created by globalwings  on 2018/11/27.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

