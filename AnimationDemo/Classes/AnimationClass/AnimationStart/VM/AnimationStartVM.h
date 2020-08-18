//
//  AnimationStartVM.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/3.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationBaseViewModel.h"
#import "TapLabel.h"

NS_ASSUME_NONNULL_BEGIN

@class ShiningLabel;

@interface AnimationStartVM : AnimationBaseViewModel

/// 创建书动画
- (void)setupBookAnimation:(UIImageView *)coverView animationVC:(UIViewController *)animationVC;
/// 创建文字闪烁动画
- (ShiningLabel *)setupShiningLabelAnimation;
/// 创建测试后门
- (TapLabel *)setupTestLab:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
