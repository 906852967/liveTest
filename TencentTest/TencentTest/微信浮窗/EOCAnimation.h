//
//  EOCAnimation.h
//  TencentTest
//
//  Created by globalwings  on 2018/12/20.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface EOCAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) CGRect curFrame;
@end

NS_ASSUME_NONNULL_END
