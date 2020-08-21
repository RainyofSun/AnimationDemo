//
//  AlphaAnimationLabel.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/20.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlphaAnimationLabel : NSObject

// label 常用属性
/** text */
@property (nonatomic,strong) NSString *text;
/** font */
@property (nonatomic,strong) UIFont *font;
/** textColor */
@property (nonatomic,strong) UIColor *textColor;

// 动画结束回调
/** animationFinishBlock */
@property (nonatomic,copy) void (^animationFinishBlock)(BOOL finish);

- (instancetype)initWithAlphaAnimationLabelFrame:(CGRect)frame;
- (UIView *)alphaAnimationLabel;
- (void)startAnimation;

@end

NS_ASSUME_NONNULL_END
