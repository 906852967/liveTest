//
//  ViewController.m
//  Turntable
//
//  Created by globalwings  on 2018/11/29.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>
{
    NSString *strPrise;
}

@property(nonatomic, strong) UIView *popView;
@property(nonatomic, strong) UILabel *labPrise;
@property(nonatomic, strong) UIButton *btn;
@property(nonatomic, strong) UIImageView *zhuanpan;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景
    UIImageView *imageBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageBg.image = [UIImage imageNamed:@"bg.png"];
    [self.view addSubview:imageBg];
    
    //转盘
    _zhuanpan = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 280) / 2, 10, 280, 280)];
    _zhuanpan.image = [UIImage imageNamed:@"zhuanpan.png"];
    [self.view addSubview:_zhuanpan];
    
    //手指
    UIImageView *hander = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    hander.center = CGPointMake(_zhuanpan.center.x, _zhuanpan.center.y - 30);
    hander.image = [UIImage imageNamed:@"hander.png"];
    [self.view addSubview:hander];
    
    
    _labPrise = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_zhuanpan.frame), CGRectGetMaxY(_zhuanpan.frame)+50, CGRectGetWidth(_zhuanpan.frame), 20)];
    _labPrise.textColor = [UIColor orangeColor];
    _labPrise.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_labPrise];
    
    //开始或停止按钮
    _btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, CGRectGetMaxY(_labPrise.frame)+50, 200, 35)];
    [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [_btn setTitle:@"开始" forState:UIControlStateNormal];
    [_btn setBackgroundColor:[UIColor orangeColor]];
    _btn.layer.borderColor = [UIColor orangeColor].CGColor;
    _btn.layer.borderWidth = 1.0f;
    _btn.layer.cornerRadius = 5.0f;
    _btn.layer.masksToBounds = YES;
    [self.view addSubview:_btn];
    
}
- (void)btnClick{
    NSInteger angle;
    NSInteger randomNum = arc4random() % 100;
    if (randomNum >= 91 && randomNum <= 99) {
        angle = 300;
        strPrise = @"一等奖";
    }else if(randomNum >= 76 && randomNum <= 99){
        angle = 60;
        strPrise = @"二等奖";
    }else if (randomNum >= 51 && randomNum <= 75){
        angle = 180;
        strPrise = @"三等奖";
    }else{
        angle = 240;
        strPrise = @"没中奖";
    }
    [_btn setTitle:@"抽奖中...." forState:UIControlStateNormal];
    _labPrise.text = [NSString stringWithFormat:@"中奖结果:%@", @"等待开奖结果"];
    _btn.enabled = NO;
    

    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:angle * M_PI/180];
    rotationAnimation.repeatCount = 10;
    rotationAnimation.speed = 8;
    rotationAnimation.duration = 2.0f;
    rotationAnimation.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [_zhuanpan.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

//动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [UIView animateWithDuration:2.0 animations:^{
        self.popView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.popView.backgroundColor = [UIColor clearColor];
        self.popView.transform = CGAffineTransformMakeScale(2, 2);
        [self.view addSubview:self.popView];
        
//        UIImageView *popImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 150, self.view.frame.size.width - 200, self.view.frame.size.width - 200)];
//        popImageView.image = [UIImage imageNamed:@"prise.png"];
        //[self.popView addSubview:popImageView];
        
    } completion:^(BOOL finished) {
        [self.popView removeFromSuperview];
        self.labPrise.text = [NSString stringWithFormat:@"中奖结果 : %@",strPrise];
        [self.btn setTitle:@"开始抽奖" forState:UIControlStateNormal];
        self.btn.enabled = YES;
    }];
}
@end
