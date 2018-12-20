//
//  EOCWeChatView.m
//  TencentTest
//
//  Created by globalwings  on 2018/12/20.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "EOCWeChatView.h"
#import "EOCSemiCirclwView.h"
#import "EOCVC.h"
#import "EOCAnimation.h"
@interface EOCWeChatView ()<UINavigationControllerDelegate>{
    CGPoint lastPoint;
    CGPoint pointInself;
}

@end
@implementation EOCWeChatView

static EOCWeChatView *floatngBtn;
static EOCSemiCirclwView *semiCircleView;
#define fixedSpace 320
+ (void)show
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        floatngBtn = [[EOCWeChatView alloc] initWithFrame:CGRectMake(10, 200, 60, 60)];
        semiCircleView = [[EOCSemiCirclwView alloc] initWithFrame:CGRectMake(kWidth - fixedSpace / 2, kHeight - fixedSpace / 2, fixedSpace, fixedSpace)];
    });
    if (!semiCircleView.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:semiCircleView];
    }
    //添加到界面 key window
    
    if (!floatngBtn.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:floatngBtn];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:floatngBtn];
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    //赋值图片
    self.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"floatBtn"].CGImage);
    self.layer.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5].CGColor;
    return self;
}

#pragma UITouch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.superview];
    pointInself = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     //计算控件中心点
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    //四分之一圆动画展示
    if (CGRectEqualToRect(semiCircleView.frame, CGRectMake(kWidth - fixedSpace / 2, kHeight - fixedSpace / 2, fixedSpace, fixedSpace))) {
        semiCircleView.frame = CGRectMake(kWidth - fixedSpace / 2, kHeight - fixedSpace / 2, fixedSpace, fixedSpace);
    }
    
    CGFloat centerX = currentPoint.x + (self.frame.size.width / 2 - pointInself.x);
    CGFloat centerY = currentPoint.y + (self.frame.size.height / 2 - pointInself.y);
    //限制centre坐标的范围值, 不超过屏幕
    //30 <= x <= kWidth - 30
    CGFloat x = MAX(30, MIN(kWidth - 30, centerX));
    CGFloat y = MAX(30, MIN(kHeight - 30, centerY));
    self.center = CGPointMake(x, y);
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    if (CGPointEqualToPoint(lastPoint, currentPoint)) {
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        nav.delegate = self;
        EOCVC *eocVC = [[EOCVC alloc] init];
        [nav pushViewController:eocVC animated:YES];
        //点击效果
        return;
    }
    //四分之一圆动画展示
    [UIView animateWithDuration:0.2 animations:^{
        //两个圆心的距离 <= 两个半径之差  小按钮在1/4圆h中
        CGFloat distance = sqrt(pow(kWidth - self.center.x, 2) + pow(kHeight - self.center.y, 2));
        if (distance <= fixedSpace / 2 - 30) {
            [self removeFromSuperview];
        }
        semiCircleView.frame = CGRectMake(kWidth + fixedSpace / 2, kHeight + fixedSpace / 2, fixedSpace, fixedSpace);
    }];
    
    //离左右两侧的距离
    CGFloat leftMargin = self.center.x;
    CGFloat rightMargin = kWidth - leftMargin;
    if (leftMargin < rightMargin) {
        [UIView animateWithDuration:0.2f animations:^{
            self.center = CGPointMake(40, self.center.y);
        }];
    }else{
        [UIView animateWithDuration:0.2f animations:^{
            self.center = CGPointMake(kWidth - 40, self.center.y);
        }];
    }
}
#pragma
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        EOCAnimation *anima = [[EOCAnimation alloc] init];
        anima.curFrame = self.frame;
        return anima;
    }
    return nil;
}
@end
