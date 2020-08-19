//
//  GradientColorHelper.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "GradientColorHelper.h"

#define UIColorFromRGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFronHSB(h,s,b)               [UIColor colorWithHue:h saturation:s brightness:b alpha:1.0f]

@implementation GradientColorHelper

#pragma mark - Linear Gradient
+ (UIImage *)getLinearGradientImage:(UIColor *)startColor and:(UIColor *)endColor directionType:(GradientDirection)directionType {
    return [self getLinearGradientImage:startColor and:endColor directionType:directionType option:CGSizeMake(kDefaultWidth, kDefaultHeight)];
}

+ (UIImage *)getLinearGradientImage:(UIColor *)startColor and:(UIColor *)endColor directionType:(GradientDirection)directionType option:(CGSize)size {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,
                            (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@(0.0f),@(1.0f)];
    if (directionType == LinearGradientDirectionLevel) {
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
    } else if (directionType == LinearGradientDirectionVertical) {
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
    } else if (directionType == LinearGradientDirectionDownDiagonalLine) {
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
    } else if (directionType == LinearGradientDirectionUpwardDiagonalLine) {
        gradientLayer.startPoint = CGPointMake(0, 1);
        gradientLayer.endPoint = CGPointMake(1, 0);
    }
    
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, NO, 0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return gradientImage;
}

#pragma mark - radial Gradient
+ (UIImage *)getRadialGradientImage:(UIColor *)centerColor and:(UIColor *)outColor {
    return [self getRadialGradientImage:centerColor and:outColor option:CGSizeMake(kDefaultWidth, kDefaultWidth)];
}

+ (UIImage *)getRadialGradientImage:(UIColor *)centerColor and:(UIColor *)outColor option:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat radius = MAX(size.width/2, size.height/2);
    CGPathAddArc(path, NULL, size.width/2, size.height/2, radius, 0, 2 * M_PI, NO);
    [self drawRadiaGradient:gc path:path startColor:centerColor.CGColor endColor:outColor.CGColor];
    CGPathRelease(path);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (void)drawRadiaGradient:(CGContextRef)context path:(CGPathRef)path startColor:(CGColorRef)startColor endColor:(CGColorRef)endColor {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0,1.0};
    NSArray *colors = @[(__bridge id)startColor,(__bridge id)endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    
    CGRect rect = CGPathGetBoundingBox(path);
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat radius = MAX(rect.size.width/2.f,rect.size.height/2.f) * sqrt(2.0);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOClip(context);
    
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, 0);
    
    CGContextRelease(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

+ (void)addGradientChromatoAnimation:(UIView *)view {
    if (view == nil) {
        return;
    }
    
    CGFloat btnHeight = view.bounds.size.height;
    CGFloat btnWidth = view.bounds.size.width;
    
    CAGradientLayer *chormatoLayer = [CAGradientLayer layer];
    [chormatoLayer setColors:@[(__bridge id)UIColorFronHSB(0.63, 0.69, 0.88).CGColor,
                            (__bridge id)UIColorFronHSB(0.75, 0.69, 0.88).CGColor]];
    [chormatoLayer setStartPoint:CGPointMake(0, 0)];
    [chormatoLayer setEndPoint:CGPointMake(1, 0)];
    [chormatoLayer setLocations:@[@(0.0f),@(1.0f)]];
    [chormatoLayer setFrame:CGRectMake(0, 0, btnWidth, btnHeight)];
    
    CAKeyframeAnimation *chormatoAnimation = [self createGradientChromatoKeyAnimation];
    [chormatoLayer addAnimation:chormatoAnimation forKey:@"chormatoAnimation"];
    
    if (chormatoLayer.superlayer == nil) {
        [view.layer insertSublayer:view.layer below:view.layer.sublayers.firstObject];
    }
}

+ (void)addLinearGradientForLableText:(UIView *)parentView lable:(UILabel *)lable start:(UIColor *)startColor and:(UIColor *)endColor {
    if (parentView == nil || lable == nil) {
        return;
    }
    
    [parentView addSubview:lable];
    
    CAGradientLayer *chormatoLayer = [CAGradientLayer layer];
    [chormatoLayer setColors:@[(__bridge id)startColor.CGColor,
                            (__bridge id)endColor.CGColor]];
    [chormatoLayer setStartPoint:CGPointMake(0, 0)];
    [chormatoLayer setEndPoint:CGPointMake(1, 0)];
    [chormatoLayer setLocations:@[@(0.0f),@(1.0f)]];
    [chormatoLayer setFrame:parentView.frame];
    
    [parentView.layer addSublayer:chormatoLayer];
    chormatoLayer.mask = lable.layer;
    chormatoLayer.frame = chormatoLayer.bounds;
}

+ (void)addGradientChromatoAnimationForLableText:(UIView *)parentView lable:(UILabel *)lable {
    if (parentView == nil || lable == nil) {
        return;
    }
    
    [parentView addSubview:lable];
    
    CAGradientLayer *chormatoLayer = [CAGradientLayer layer];
    [chormatoLayer setColors:@[(__bridge id)UIColorFronHSB(0.63, 0.69, 0.88).CGColor,
                            (__bridge id)UIColorFronHSB(0.75, 0.69, 0.88).CGColor]];
    [chormatoLayer setStartPoint:CGPointMake(0, 0)];
    [chormatoLayer setEndPoint:CGPointMake(1, 0)];
    [chormatoLayer setLocations:@[@(0.0f),@(1.0f)]];
    [chormatoLayer setFrame:parentView.frame];
    
    CAKeyframeAnimation *chormatoAnimation = [self createGradientChromatoKeyAnimation];
    [chormatoLayer addAnimation:chormatoAnimation forKey:@"chormatoAnimation"];
    
    [parentView.layer addSublayer:chormatoLayer];
    chormatoLayer.mask = lable.layer;
    chormatoLayer.frame = chormatoLayer.bounds;
}

#pragma mark - private method

+ (CAKeyframeAnimation *)createGradientChromatoKeyAnimation {
    CAKeyframeAnimation *chromateAnimate = [CAKeyframeAnimation animationWithKeyPath:@"colors"];
    
    chromateAnimate.values = @[@[(__bridge id)UIColorFronHSB(0.63, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.75, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.73, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.85, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.83, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.95, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.88, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(1, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.98, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.1, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(1, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.12, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.1, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.22, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.2, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.32, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.3, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.42, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.4, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.52, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.5, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.62, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.6, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.72, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.63, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.75, 0.69, 0.88).CGColor]];
    chromateAnimate.keyTimes = @[@0, @0.1, @0.2, @0.25, @0.35, @0.37, @0.47, @0.57, @0.67, @0.77, @0.87, @0.97, @1];
    chromateAnimate.duration = 6;
    chromateAnimate.removedOnCompletion = NO;
    chromateAnimate.repeatCount = MAXFLOAT;
    
    return chromateAnimate;
}

@end
