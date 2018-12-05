//
//  PopVC.m
//  runTime
//
//  Created by globalwings  on 2018/12/5.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "PopVC.h"

#define WIDTH [[UIScreen mainScreen] bounds].size.width
@interface PopVC ()

@end

@implementation PopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(WIDTH, 0, 0, 0)];
    view.backgroundColor = [UIColor colorWithRed:123 / 255.0 green:104 / 255.0 blue:238 / 255.0 alpha:0.2];
    [self.view addSubview:view];
    
    UIView *smallView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    smallView.backgroundColor = [UIColor yellowColor];
    smallView.layer.cornerRadius = smallView.frame.size.width / 2;
    smallView.layer.masksToBounds = YES;
    smallView.alpha = 0.5;
    [view addSubview:smallView];
    
    
    
    [UIView animateWithDuration:4 animations:^{
        view.frame = [UIScreen mainScreen].bounds;
        smallView.frame = CGRectMake(0, 0, 300, 300);
        smallView.center = view.center;
        smallView.layer.cornerRadius = smallView.frame.size.width / 2;
        smallView.layer.masksToBounds = YES;
        view.alpha = 0.51;
    } completion:^(BOOL finished) {
        view.backgroundColor = [UIColor redColor];
        view.alpha = 0.9;
        
    }];
    
}
@end
