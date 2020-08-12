//
//  DrawingBoardCanvasView.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/5.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawingBoardCanvasView : UIView

/// 清屏
- (void)clearScreenOperation;
/// 撤销
- (void)revocationOperation;
/// 擦除
- (void)eraseScreenOperation;
/// 停止擦除
- (void)stopEraseScreenOperation;
/// 保存轨迹
- (BOOL)saveTrajectory;
/// 读取轨迹
- (NSArray <NSValue *>*)readTrajectory;
/// 修改画笔宽度
- (void)changeBrushWidth:(CGFloat)brushWidth;
/// 修改画笔颜色
- (void)changeBrushColor:(UIColor *)brushColor;
/// 设置画板背景色 默认ClearColor
- (void)setDrawingBoardBackgroudColor:(UIColor *)bgColor;
/// 修改线条模式 默认normal
- (void)changeBlendModeInErase:(CGBlendMode)blendModel;

@end

NS_ASSUME_NONNULL_END
