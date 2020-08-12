//
//  ShiningLabel.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/3.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ST_LeftToRight, // 左至右
    ST_RightToLeft, // 右至左
    ST_AutoReverse, // 左右来回
    ST_ShimmerAll,  // 整体闪烁
} ShimmerType;      // 闪烁类型

@interface ShiningLabel : UIView

// UILabel 常用属性
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) NSAttributedString *attributedText;
@property (nonatomic,assign) NSInteger numberOfLines;
@property (nonatomic,assign) NSTextAlignment textAlignment;

// ShiningLabel 属性
/** shimmerType 闪烁类型 */
@property (nonatomic,assign) ShimmerType shimmerType;
/** repeat 循环播放 默认是 */
@property (nonatomic,assign) BOOL repeat;
/** isPlaying 是否在播放动画 */
@property (nonatomic,assign,readonly) BOOL isPlaying;
/** shimmerWidth 闪烁宽度 默认20 */
@property (nonatomic,assign) CGFloat shimmerWidth;
/** shimmerRadius 闪烁半径 默认20 */
@property (nonatomic,assign) CGFloat shimmerRadius;
/** durationTime 闪烁持续时间 默认2秒 */
@property (nonatomic,assign) NSTimeInterval durationTime;
/** shimmerColor 闪烁颜色 默认白 */
@property (nonatomic,strong) UIColor *shimmerColor;

/// 开始闪烁,闪烁期间更改以上属性立即生效
- (void)startShimmer;
/// 前后台切换重新开始动画
- (void)restartAnimation;
/// 停止闪烁
- (void)endShimmer;

@end

NS_ASSUME_NONNULL_END
