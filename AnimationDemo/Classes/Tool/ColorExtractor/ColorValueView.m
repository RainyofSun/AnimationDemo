//
//  ColorValueView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "ColorValueView.h"

/** 角度换算弧度 π */
#define AngleToRadian(angle)  (M_PI * angle / 180.0 )

@implementation ColorValueView

+ (instancetype)valveView:(UIView *)view {
    ColorValueView *valueView = [[ColorValueView alloc] init];
    [view addSubview:valueView];
    return valueView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self colorValueInit];
    }
    return self;
}

#pragma mark - private methods
- (void)colorValueInit {
    self.frame = CGRectMake(0, 0, 50, 50);
    self.layer.cornerRadius = 25;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor redColor];
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 4.f;
    
    UIView *point = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 2)];
    point.center = CGPointMake(self.center.x, self.center.y);
    point.layer.cornerRadius = 1;
    point.clipsToBounds = YES;
    point.backgroundColor = [UIColor redColor];
    [self addSubview:point];
}

+ (CGPoint)valveTheCenterWithCircleRadius:(CGFloat)circleRadius moveAngle:(CGFloat)moveAngle point:(CGPoint)point centerPoint:(CGPoint)centerPoint {
    CGPoint center = CGPointZero;
    CGFloat x = sin(AngleToRadian(moveAngle)) * circleRadius;
    CGFloat y = cos(AngleToRadian(moveAngle)) * circleRadius;
    
    if (point.x <= centerPoint.x) {
        center.x = centerPoint.x - x;
    } else if (point.x > centerPoint.x) {
        center.x = centerPoint.x + x;
    }
    center.y = centerPoint.y - y;
    
    return center;
}

+ (UIColor *)colorAtPixel:(CGPoint)point withImage:(UIImage *)image imageWidth:(CGFloat)imageWidth {
    if (!CGRectContainsPoint(CGRectMake(0, 0, image.size.width, image.size.height), point)) {
        return nil;
    }
    
    //    trunc（n1,n2），n1表示被截断的数字，n2表示要截断到那一位。n2可以是负数，表示截断小数点前。注意，TRUNC截断不是四舍五入。
    //    TRUNC(15.79)---15
    //    trunc(15.79,1)--15.7
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    
    CGImageRef cgImage = image.CGImage;
    
    NSUInteger width = imageWidth;
    NSUInteger height = imageWidth;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytePerPixel = 4;
    int bytesPerRow = bytePerPixel * 1;
    
    NSUInteger bitesPerComponent = 8;
    unsigned char pixelData[4] = {0,0,0,0};
    
    CGContextRef context = CGBitmapContextCreate(pixelData, 1, 1, bitesPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextTranslateCTM(context, -pointX, pointY - (CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0, 0, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    CGFloat red     = (CGFloat)pixelData[0] / 255.f;
    CGFloat green   = (CGFloat)pixelData[1] / 255.f;
    CGFloat blue    = (CGFloat)pixelData[2] / 255.f;
    CGFloat alpha   = (CGFloat)pixelData[3] / 255.f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorAtPixel:(CGPoint)point withImage:(UIImage *)image {
    return [self colorAtPixel:point withImage:image imageWidth:image.size.width];
}

@end
