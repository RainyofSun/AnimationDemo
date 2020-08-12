//
//  ColorValueView.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorValueView : UIView

+ (instancetype)valveView:(UIView *)view;

/**
 计算 指示球中心点 在圆形的位置

 @param circleRadius 大圆半径
 @param moveAngle 夹角 （与 Y轴 的夹角）
 @param point 移动的当前 point 点
 @param centerPoint 圆心center
 @return 计算出指示球的point
 */
+ (CGPoint)valveTheCenterWithCircleRadius:(CGFloat)circleRadius moveAngle:(CGFloat)moveAngle point:(CGPoint)point centerPoint:(CGPoint)centerPoint;



/**
 获取图片某一点的颜色
 
 @param point 点击图片的某一点
 @param image 图片
 @return 图片某点的颜色值
 */
+ (UIColor *)colorAtPixel:(CGPoint)point withImage:(UIImage *)image;

+ (UIColor *)colorAtPixel:(CGPoint)point withImage:(UIImage *)image imageWidth:(CGFloat)imageWidth;

@end

NS_ASSUME_NONNULL_END
