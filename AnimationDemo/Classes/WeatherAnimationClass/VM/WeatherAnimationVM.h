//
//  WeatherAnimationVM.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherAnimationVM : AnimationBaseViewModel

/// 创建天气动画
- (void)setupWeatherAnimation:(UIView *)animationView;
/// 停止动画
- (void)weatherAnimationStop;
/// bottomMenuView
- (void)addBottomMenuView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
