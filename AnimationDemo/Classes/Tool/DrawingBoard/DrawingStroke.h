//
//  DrawingStroke.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct CGPath *CGMutablePathRef;

@interface DrawingStroke : NSObject

@property (nonatomic)CGMutablePathRef path;
@property (nonatomic,assign) CGBlendMode blendMode;
@property (nonatomic,assign) CGFloat strokeWidth;
@property (nonatomic,strong) UIColor *lineColor;

- (void)strokeWithContext:(CGContextRef)context;

@end

NS_ASSUME_NONNULL_END
