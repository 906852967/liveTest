//
//  ViewController.m
//  TencentTest
//
//  Created by globalwings  on 2018/12/18.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "ViewController.h"
#import "NavView.h"
#import "微信浮窗/EOCWeChatView.h"

static const CGFloat headHeight = 160;
static const CGFloat retio = 0.8;

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) NavView *navView;
@property (nonatomic, assign) CGRect originalFrame;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
- (void)setUI
{
    
    _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _backImage.image = [UIImage imageNamed:@"bg_mine"];
    _backImage.contentMode = UIViewContentModeScaleAspectFit;
    _originalFrame = _backImage.frame;
    [self.view addSubview:_backImage];
    
    //导航栏
    _navView = [[NavView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.view addSubview:_navView];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.showsVerticalScrollIndicator = NO;
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.rowHeight = 45;
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //tableview.contentInset = UIEdgeInsetsMake(headHeight, 0, 0, 0);
    [self.view addSubview:tableview];
    
    tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    //添加headerView
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, headHeight)];
    headView.backgroundColor = [UIColor clearColor];
    tableview.tableHeaderView = headView;
    tableview.contentSize = CGSizeMake(0, kHeight + 50);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"学习学三生三世十";
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [EOCWeChatView show];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset < headHeight) {
        //当滑动到导航栏底部之前
        CGFloat colorAlpha = yOffset / headHeight;
        _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:colorAlpha];
    }else{
        _navView.backgroundColor = [UIColor whiteColor];
    }
    NSLog(@"yOffset = %f", yOffset);
    //往上移动效果, 处理放大效果
    if (yOffset >= -44) {
        _backImage.frame = ({
            CGRect frame = _originalFrame;
            frame.origin.y = _originalFrame.origin.y - yOffset;
            frame;
        });
    }else{
        _backImage.frame = ({
            CGRect frame = _originalFrame;
            frame.size.height = _originalFrame.size.height - yOffset;
            frame.size.width = frame.size.height / retio;
            frame.origin.x = _originalFrame.origin.x - (frame.size.width - _originalFrame.size.width) / 2;
            frame;
        });
    }
    NSLog(@"_backImage.frame.size.height = %f, _backImage.frame.origin.y = %f", _backImage.frame.size.height, _backImage.frame.origin.y);
}
@end
