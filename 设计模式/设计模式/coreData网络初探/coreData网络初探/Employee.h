//
//  Employee.h
//  coreData网络初探
//
//  Created by globalwings  on 2018/11/27.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
NS_ASSUME_NONNULL_BEGIN

@interface Employee : NSManagedObject
@property(copy,nonatomic) NSDate *birthday;
@property(assign,nonatomic) float height;
@property(copy,nonatomic) NSString *name;
@end

NS_ASSUME_NONNULL_END
