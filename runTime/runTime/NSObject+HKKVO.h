//
//  NSObject+HKKVO.h
//  runTime
//
//  Created by globalwings  on 2018/11/16.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HKKVO)
- (void)HK_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
@end

NS_ASSUME_NONNULL_END
