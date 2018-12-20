//
//  EOCSemiCirclwView.m
//  TencentTest
//
//  Created by globalwings  on 2018/12/20.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import "EOCSemiCirclwView.h"

@implementation EOCSemiCirclwView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = frame.size.width / 2;
        self.layer.masksToBounds = YES;
    }
    return self;
}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(context, [UIColor cyanColor].CGColor);
//    CGContextMoveToPoint(context, rect.size.width, 0);
//    CGContextSetLineWidth(context, rect.size.width);
//    CGContextAddArcToPoint(context, rect.size.width, 0, 0, rect.size.height, rect.size.width);
//    CGContextStrokePath(context);
//}

@end
