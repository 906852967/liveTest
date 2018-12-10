//
//  TransVC.m
//  runTime
//
//  Created by globalwings  on 2018/12/10.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "TransVC.h"

/**
 动画效果
 */
typedef NS_ENUM(NSUInteger, MCTransitonAnimType) {
    MCTransitonAnimTypeFade = 0,    //渐变，效果不明显
    MCTransitonAnimTypeMoveIn,      //新的移入
    MCTransitonAnimTypeReveal,      //旧的移出
    MCTransitonAnimTypePush,         //推入,新的推入旧的推出
    MCTransitonAnimTypePageCurl,    // 向上翻一页
    MCTransitonAnimTypePageUnCurl,  // 向下翻一页
    MCTransitonAnimTypeRippleEffect,// 波纹
    MCTransitonAnimTypeSuckEffect,  // 像一块布被抽走
    MCTransitonAnimTypeCube,        // 立方体
    MCTransitonAnimTypeOglFlip,     // 平面反转
    MCTransitonAnimTypeCameraIrisHollowOpen, //摄像机开
    MCTransitonAnimTypeCameraIrisHollowClose //摄像机关
    
};

/**
 动画方向
 */
typedef NS_ENUM(NSUInteger, MCTransitonAnimDirection) {
    MCTransitonAnimDirectionFromLeft,
    MCTransitonAnimDirectionFromRight,
    MCTransitonAnimDirectionFromTop,
    MCTransitonAnimDirectionFromBottom
};

/**
 动画的速度变化
 */
typedef NS_ENUM(NSUInteger, MCTransitonAnimTimingFunc) {
    MCTransitonAnimTimingFuncLinear,      //线性
    MCTransitonAnimTimingFuncEaseIn,      //慢入
    MCTransitonAnimTimingFuncEaseOut,     //慢出
    MCTransitonAnimTimingFuncEaseInEaseOut//慢入慢出
};
@interface TransVC ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;
@end

@implementation TransVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.button];
    
}
- (UIButton *)button{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor orangeColor];
        _button.frame = CGRectMake(100, 400, 100, 50);
        [_button addTarget:self action:@selector(transButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
- (void)transButton{
    _button.hidden = YES;
    
    CATransition *trans = [self setTransitionAnimationWithType:MCTransitonAnimTypeRippleEffect duration:1.0f direction:MCTransitonAnimDirectionFromLeft timingFunc:MCTransitonAnimTimingFuncLinear];
    [self.imageView.layer addAnimation:trans forKey:@"trans"];
    _button.hidden = NO;
}
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(100, 100, 300, 200);
        _imageView.image = [UIImage imageNamed:@"999.jpg"];
        [self.view addSubview:_imageView];
    }
    return _imageView;
}
- (CATransition *)setTransitionAnimationWithType:(MCTransitonAnimType)animType
                              duration:(float)duration
                             direction:(MCTransitonAnimDirection)subtype
                            timingFunc:(MCTransitonAnimTimingFunc)timingFunc
{
    CATransition *trans = [CATransition animation];
    trans.duration = duration;
    // 动画种类
    switch (animType) {
        case MCTransitonAnimTypeFade://渐变，效果不明显
            trans.type = kCATransitionFade;
            break;
        case MCTransitonAnimTypeMoveIn://新的移入
            trans.type = kCATransitionMoveIn;
            break;
        case MCTransitonAnimTypeReveal://旧的移出
            trans.type = kCATransitionReveal;
            break;
        case MCTransitonAnimTypePush://推入,新的推入旧的推出
            trans.type = kCATransitionPush;
            break;
        case MCTransitonAnimTypePageCurl:// 向上翻一页
            trans.type = @"pageCurl";
            break;
        case MCTransitonAnimTypePageUnCurl:// 向下翻一页
            trans.type = @"pageUnCurl";
            break;
        case MCTransitonAnimTypeRippleEffect:// 波纹
            trans.type = @"rippleEffect";
            break;
        case MCTransitonAnimTypeSuckEffect:// 像一块布被抽走
            trans.type = @"suckEffect";
            break;
        case MCTransitonAnimTypeCube:// 立方体
            trans.type = @"cube";
            break;
        case MCTransitonAnimTypeOglFlip:// 平面反转
            trans.type = @"oglFlip";
            break;
        case MCTransitonAnimTypeCameraIrisHollowOpen://摄像机开
            trans.type = @"cameraIrisHollowOpen";
            break;
        case MCTransitonAnimTypeCameraIrisHollowClose://摄像机关
            trans.type = @"cameraIrisHollowClose";
            break;
        default:
            break;
    }
    // 动画的速度变化
    switch (timingFunc) {
        case MCTransitonAnimTimingFuncLinear:
            trans.timingFunction =  [CAMediaTimingFunction functionWithName:@"linear"];
            break;
        case MCTransitonAnimTimingFuncEaseIn:
            trans.timingFunction =  [CAMediaTimingFunction functionWithName:@"easeIn"];
            break;
        case MCTransitonAnimTimingFuncEaseOut:
            trans.timingFunction =  [CAMediaTimingFunction functionWithName:@"easeOut"];
            break;
        case MCTransitonAnimTimingFuncEaseInEaseOut:
            trans.timingFunction =  [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
            break;
        default:
            break;
    }
    switch (subtype) {
        case MCTransitonAnimDirectionFromLeft:
            trans.subtype = kCATransitionFromLeft;
            break;
        case MCTransitonAnimDirectionFromRight:
            trans.subtype = kCATransitionFromRight;
            break;
        case MCTransitonAnimDirectionFromTop:
            trans.subtype = kCATransitionFromTop;
            break;
        case MCTransitonAnimDirectionFromBottom:
            trans.subtype = kCATransitionFromBottom;
            break;
        default:
            break;
    }
    return trans;
}
@end
