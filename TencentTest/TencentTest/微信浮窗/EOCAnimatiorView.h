//
//  EOCAnimatiorView.h
//  TencentTest
//
//  Created by globalwings  on 2018/12/20.
//  Copyright © 2018 globalwings . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EOCAnimatiorView : UIImageView

- (void)startAnimaWithView:(UIView *)theView fromRect:(CGRect)fromRect toRect:(CGRect)toRect;
@end

NS_ASSUME_NONNULL_END
