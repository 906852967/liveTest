//
//  NSURL+url.h
//  runTime
//
//  Created by globalwings  on 2018/11/16.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (url)
+(instancetype)HK_URLWithString:(NSString *)str;
+(void)load;
@end

NS_ASSUME_NONNULL_END
