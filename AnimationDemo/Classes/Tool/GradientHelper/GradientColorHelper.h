//
//  GradientColorHelper.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kDefaultWidth 200
#define kDefaultHeight 200

typedef NS_ENUM(NSInteger, GradientDirection) {
    LinearGradientDirectionLevel,                 //AC - BD
    LinearGradientDirectionVertical,              //AB - CD
    LinearGradientDirectionUpwardDiagonalLine,    //A - D
    LinearGradientDirectionDownDiagonalLine,      //C - B
};
//      A         B
//       _________
//      |         |
//      |         |
//       ---------
//      C         D

@interface GradientColorHelper : NSObject

//   Linear Gradient
+ (UIImage *)getLinearGradientImage:(UIColor *)startColor and:(UIColor *)endColor directionType:(GradientDirection)directionType;/* CGSizeMake(kDefaultWidth, kDefaultHeight) */
+ (UIImage *)getLinearGradientImage:(UIColor *)startColor and:(UIColor *)endColor directionType:(GradientDirection)directionType option:(CGSize)size;

//    Radial Gradient
+ (UIImage *)getRadialGradientImage:(UIColor *)centerColor and:(UIColor *)outColor;/* raduis = kDefaultWidth / 2 */
+ (UIImage *)getRadialGradientImage:(UIColor *)centerColor and:(UIColor *)outColor option:(CGSize)size;

//   ChromatoAnimation
+ (void)addGradientChromatoAnimation:(UIView *)view;

//   LableText LinearGradient and ChromatoAnimation
+ (void)addLinearGradientForLableText:(UIView *)parentView lable:(UILabel *)lable start:(UIColor *)startColor and:(UIColor *)endColor;  /* don't need call 'addSubview:' for lable */
+ (void)addGradientChromatoAnimationForLableText:(UIView *)parentView lable:(UILabel *)lable; /* don't need call 'addSubview:' for lable */

@end

NS_ASSUME_NONNULL_END
