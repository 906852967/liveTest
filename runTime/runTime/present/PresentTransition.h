//
//  PresentTransition.h
//  runTime
//
//  Created by globalwings  on 2018/12/4.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TransitionType) {
    TransitionOneTypePresent = 0,
    TransitionOneTypeDissmiss,
    TransitionOneTypePush,
    TransitionOneTypePop,
};
@interface PresentTransition : NSObject<UIViewControllerAnimatedTransitioning>

//动画转场类型
@property(nonatomic, assign) TransitionType transitionType;
@end

NS_ASSUME_NONNULL_END
