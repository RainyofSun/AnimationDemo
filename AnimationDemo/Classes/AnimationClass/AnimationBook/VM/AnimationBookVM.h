//
//  AnimationBookVM.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/4.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationBaseViewModel.h"
#import "TapLabel.h"
#import "IrregularityLabel.h"
#import "SnowAnimationView.h"
#import "CherryTreeAnimationView.h"
#import "DrawWordsAnimationLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface AnimationBookVM : AnimationBaseViewModel

/// 创建书本动画
- (void)setupBookAnimation:(UIViewController *)bookVC;
/// 创建点击的label
- (TapLabel *)setupTapLabel:(void(^)(id animationThings))touchCallBack;
/// 创建不规则的label
- (IrregularityLabel *)setupIrregularityLabel;
/// 创建下雪动画
- (SnowAnimationView *)setupSnowAnimation;
/// 创建樱花动画
- (CherryTreeAnimationView *)setupCherryTreeAnimation;
/// 创建文字动画
- (void)setupWordsAnimation:(NSString *)animationText animationView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
