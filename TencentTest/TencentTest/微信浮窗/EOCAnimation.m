//
//  EOCAnimation.m
//  TencentTest
//
//  Created by globalwings  on 2018/12/20.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "EOCAnimation.h"
#import "EOCAnimatiorView.h"
@implementation EOCAnimation
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // A控制器  跳转到  B控制器
    UIView *containerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    
    EOCAnimatiorView *animatorView = [[EOCAnimatiorView alloc] initWithFrame:toView.bounds];
    [containerView addSubview:animatorView];
    //截屏
    UIGraphicsBeginImageContext(toView.frame.size);
    [toView.layer renderInContext:UIGraphicsGetCurrentContext()];
    animatorView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    toView.hidden = YES;
    
    //animatorView 它是从floatingBtn当前的frame
    [animatorView startAnimaWithView:toView fromRect:_curFrame toRect:toView.frame];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [transitionContext completeTransition:YES]; 
    });
     //移除frameViewC
    
}

@end
