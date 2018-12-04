//
//  TestVC.m
//  runTime
//
//  Created by globalwings  on 2018/12/3.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "TestVC.h"
#import "PresentTransition.h"
@interface TestVC ()<UIViewControllerTransitioningDelegate>

@property(nonatomic, strong) PresentTransition *present;
@end

@implementation TestVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.present.transitionType = TransitionOneTypePresent;
        self.modalTransitionStyle = UIModalPresentationCustom;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.imageView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.imageView addGestureRecognizer:pan];
    
}
- (void)tapClicked{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    
    CGPoint  translation = [panGesture translationInView:self.imageView];
    CGFloat percentComplete = 0.0;
    
    self.imageView.center = CGPointMake(self.imageView.center.x + translation.x,
                                        self.imageView.center.y + translation.y);
    [panGesture setTranslation:CGPointZero inView:self.imageView];
    
    percentComplete = (self.imageView.center.y - self.view.frame.size.height/ 2) / (self.view.frame.size.height/2);
    percentComplete = fabs(percentComplete);
    NSLog(@"%f",percentComplete);
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            self.view.alpha = 1 - percentComplete;
            break;
        case UIGestureRecognizerStateEnded:{
            
            if (percentComplete > 0.5) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                self.imageView.center = CGPointMake(self.view.center.x,
                                                    self.view.center.y);
                self.view.alpha = 1;
            }
            break;
        }
        default:
            break;
    }
    
}
- (UIImageView *)imageView{
    
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height/2)];
        _imageView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
        _imageView.image = [UIImage imageNamed:@"piao"];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked)];
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}
- (PresentTransition *)present
{
    if (_present == nil) {
        _present = [[PresentTransition alloc] init];
        self.transitioningDelegate = self;
    }
    return _present;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.present;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.present.transitionType = TransitionOneTypeDissmiss;
    return self.present;
}
@end
