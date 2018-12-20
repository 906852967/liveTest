//
//  EOCAnimatiorView.m
//  TencentTest
//
//  Created by globalwings  on 2018/12/20.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "EOCAnimatiorView.h"

@interface EOCAnimatiorView ()<CAAnimationDelegate>{
    CAShapeLayer *shareLayer;
    UIView *toView;
}

@end
@implementation EOCAnimatiorView
- (void)startAnimaWithView:(UIView *)theView fromRect:(CGRect)fromRect toRect:(CGRect)toRect
{
    toView = theView;
    //mask 圆形mask  和按钮一样
    shareLayer = [CAShapeLayer layer];
    shareLayer.path = [UIBezierPath bezierPathWithRoundedRect:fromRect cornerRadius:30].CGPath;
    self.layer.mask = shareLayer;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.toValue = (__bridge id _Nullable)([UIBezierPath bezierPathWithRoundedRect:toRect cornerRadius:30].CGPath);
    anim.duration = 0.5;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    [shareLayer addAnimation:anim forKey:nil];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    toView.hidden = NO;
    [shareLayer removeAllAnimations];
    [self removeFromSuperview];
}
@end
