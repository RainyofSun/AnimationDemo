//
//  DrawingStroke.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "DrawingStroke.h"

@implementation DrawingStroke

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)strokeWithContext:(CGContextRef)context {
    CGContextSetStrokeColorWithColor(context, [_lineColor CGColor]);
    CGContextSetLineWidth(context, _strokeWidth);
    CGContextSetBlendMode(context, _blendMode);
    CGContextBeginPath(context);
    CGContextAddPath(context, _path);
    CGContextStrokePath(context);
}

@end
