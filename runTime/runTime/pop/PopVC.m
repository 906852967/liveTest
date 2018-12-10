//
//  PopVC.m
//  runTime
//
//  Created by globalwings  on 2018/12/5.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "PopVC.h"
#import <WebKit/WebKit.h>
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height
@interface PopVC ()<CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UIView *animationView;
@end

@implementation PopVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.animationView.hidden = YES;
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(WIDTH, 0, 0, 0)];
//    view.backgroundColor = [UIColor colorWithRed:123 / 255.0 green:104 / 255.0 blue:238 / 255.0 alpha:0.2];
//    [self.view addSubview:view];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
//    [webView setCenter:view.center];
    NSData *gif = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"黑底" ofType:@"gif"]];
    webView.userInteractionEnabled = NO;
    webView.alpha = 0;
    [webView loadData:gif MIMEType:@"image/gif" characterEncodingName:@"UTF-8" baseURL:nil];
//    webView.backgroundColor = [UIColor blueColor];
    webView.opaque = NO;
    
    [self.view addSubview:webView];
    
    
    _image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg-18.jpeg"]];
    _image.userInteractionEnabled = YES;
    _image.hidden = YES;
    _image.frame = CGRectMake(0, 0, WIDTH, WIDTH);
    [self.view addSubview:_image];
    
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTag)];
    [_image addGestureRecognizer:tag];
    
    
    
//    UIView *smallView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
//    smallView.backgroundColor = [UIColor yellowColor];
//    smallView.layer.cornerRadius = smallView.frame.size.width / 2;
//    smallView.layer.masksToBounds = YES;
//    smallView.alpha = 0.5;
//    [view addSubview:smallView];
    
    
    
    [UIView animateWithDuration:4 animations:^{
        //view.frame = [UIScreen mainScreen].bounds;
//        smallView.frame = CGRectMake(0, 0, 300, 300);
//        smallView.center = view.center;
//        smallView.layer.cornerRadius = smallView.frame.size.width / 2;
//        smallView.layer.masksToBounds = YES;
        //webView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        webView.alpha = 1;
    } completion:^(BOOL finished) {
        //view.backgroundColor = [UIColor redColor];
        //view.alpha = 0.9;
        [UIView animateWithDuration:4 animations:^{
            webView.alpha = 0;
        } completion:^(BOOL finished) {
            webView.hidden = YES;
            self.image.hidden = NO;
        }];
    }];
    
}
//spring动画
- (void)springAnimationTest{
    [UIView animateWithDuration:3 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:100 options:UIViewAnimationOptionRepeat animations:^{
        self.animationView.transform = CGAffineTransformScale(self.animationView.transform, 0.5, 0.5);
        self.animationView.transform = CGAffineTransformRotate(self.animationView.transform, M_PI_4);
        self.animationView.transform = CGAffineTransformTranslate(self.animationView.transform, 100, 100);
    } completion:^(BOOL finished) {
        
    }];
}
//Keyframes
- (void)KeyframesAnimation{
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubicPaced animations:^{
        self.animationView.backgroundColor = [UIColor blueColor];
        self.animationView.frame = CGRectMake(0, 0, 100, 100);
        
    } completion:nil];
    
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubicPaced animations:^{
        self.animationView.backgroundColor = [UIColor grayColor];
        self.animationView.frame = CGRectMake(300, 200, 500, 300);
    } completion:nil];
    
    [UIView animateKeyframesWithDuration:1.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubicPaced animations:^{
        self.animationView.backgroundColor = [UIColor greenColor];
        self.animationView.frame = CGRectMake(700, 40, 150, 400);
    } completion:nil];
    
    [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubicPaced animations:^{
        self.animationView.backgroundColor = [UIColor redColor];
        self.animationView.frame = CGRectMake(200, 300, 300, 200);
    } completion:nil];
}
//💓
- (void)heartbeat{
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.cornerRadius = 50;
    [self.view.layer addSublayer:layer];
    
    //配置CABasicAnimation
    CABasicAnimation *baseLayer = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    baseLayer.fromValue = [NSNumber numberWithFloat:1.0];
    baseLayer.fromValue = [NSNumber numberWithFloat:1.5];
    
    baseLayer.autoreverses = YES;
    baseLayer.removedOnCompletion = NO;
    baseLayer.duration = 0.5;
    baseLayer.repeatCount = MAXFLOAT;
    [layer addAnimation:baseLayer forKey:@"baseLayer"];
}
- (UIView *)animationView{
    if (_animationView == nil) {
        _animationView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH / 2 - 150, 100, 200, 200)];
        _animationView.backgroundColor = [UIColor purpleColor];
        [self.view addSubview:_animationView];
    }
    return _animationView;
}
- (void)imageTag{
    _image.userInteractionEnabled = NO;
//    _image.image = [UIImage imageNamed:@"timg-18.jpeg"];
    NSInteger count = random() % 5 ;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 4;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = 0;
    animation.toValue = @(16 * M_PI + count * M_PI_2);
    animation.repeatDuration = 4;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    animation.delegate = self;
    [_image.layer addAnimation:animation forKey:@"trans"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    [UIView animateWithDuration:2 animations:^{
        self.image.alpha = 0;
    } completion:^(BOOL finished) {
        self.image.userInteractionEnabled = YES;
        self.animationView.hidden = NO;
        //spring
        //[self springAnimationTest];
        //Keyframes
       //[self KeyframesAnimation];
        //💓
        [self heartbeat];
    }];
}
@end
