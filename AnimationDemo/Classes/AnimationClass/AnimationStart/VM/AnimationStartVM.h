//
//  AnimationStartVM.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/3.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ShiningLabel;

@interface AnimationStartVM : AnimationBaseViewModel

/// 创建书动画
- (void)setupBookAnimation:(UIImageView *)coverView animationVC:(UIViewController *)animationVC;
/// 创建文字闪烁动画
- (ShiningLabel *)setupShiningLabelAnimation;

@end

NS_ASSUME_NONNULL_END
