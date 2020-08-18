//
//  WeatherThrunderAnimationLayer.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/18.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "WeatherThrunderAnimationLayer.h"

@interface WeatherThrunderAnimationLayer ()

/** pointArr 主干上的点 */
@property (nonatomic,strong) NSMutableArray *pointArr;
/** branchLightningStartPointArr */
@property (nonatomic,strong) NSMutableArray *branchLightningStartPointArr;
/** bezierPathArr */
@property (nonatomic,strong) NSMutableArray *bezierPathArr;

@end

@implementation WeatherThrunderAnimationLayer

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - override
- (void)startAnimation {
    [super startAnimation];
    [self flashRandomTimes];
    self.speed = 1.f;
}

- (void)stopAnimation {
    [super stopAnimation];
}

#pragma mark - private methods
- (void)flashRandomTimes {
    [self deleteSubLayers];
    for (NSInteger i = 0; i < arc4random()%4; i ++) {
        [self drawLightning];
    }
    NSInteger randAfter = arc4random()%6;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(randAfter * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self flashRandomTimes];
    });
}

#pragma mark - 绘制闪电
- (void)drawLightning {
    [self setupLightPointArrayWithStartPoint:CGPointMake(arc4random()%375, [UIScreen mainScreen].bounds.size.width * 0.04 + arc4random()%10) endPoint:CGPointMake(arc4random()%375, arc4random()%100 + 500) displace:3];
    [self setupBranchLightningPoint];
    [self setupLightningPath];
    [self setupLightningAnimation];
}

#pragma mark - 横向线动画
- (void)lineAnimationWithRect:(CGRect)rect {
    CGPoint point;
    [self setupPointArray];
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i < self.pointArr.count; i ++) {
        point = CGPointFromString(self.pointArr[i]);
        if (i == 0) {
            // 设置起点
            [path moveToPoint:point];
        } else {
            //设置第二个条线的终点,会自动把上一个终点当做起点
            [path addLineToPoint:point];
        }
    }
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.frame;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [UIColor whiteColor].CGColor;
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 1.f;
    pathLayer.lineJoin = kCALineJoinMiter;
    [self addSublayer:pathLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = .2f;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
    pathAnimation.repeatCount = 1;
    
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

#pragma mark - 永久闪烁动画
- (CABasicAnimation *)opacityForeverAnimation:(float)time {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}

#pragma mark - 删除子Layer
- (void)deleteSubLayers {
    if (self.sublayers.count) {
        NSArray *tempArray = [self.sublayers copy];
        for (id layer in tempArray) {
            if ([layer isKindOfClass:[CAShapeLayer class]]) {
                CAShapeLayer *tempLayer = (CAShapeLayer *)layer;
                [tempLayer removeFromSuperlayer];
                tempLayer = nil;
            }
        }
    }
    [self.bezierPathArr removeAllObjects];
}

#pragma mark - 设置闪电主干的点
- (void)setupLightPointArrayWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint displace:(CGFloat)displace {
    CGFloat midX = startPoint.x;
    CGFloat midY = startPoint.y;
    [self.pointArr removeAllObjects];
    [self.pointArr addObject:NSStringFromCGPoint(startPoint)];
//     NSLog(@"-----create first point  %@",NSStringFromCGPoint(CGPointMake(midX, midY)));
    while (midY < endPoint.y) {
        if (startPoint.x < [UIScreen mainScreen].bounds.size.width/2) {
            midX += (arc4random()%3 - 0.5) * displace;
            midY += (arc4random()%5 - 0.5) * displace;
        } else {
            midX -= (arc4random()%3 - 0.5) * displace;
            midY += (arc4random()%5 - 0.5) * displace;
        }
//        NSLog(@"-----create point  %@",NSStringFromCGPoint(CGPointMake(midX, midY)));
        [self.pointArr addObject:NSStringFromCGPoint(CGPointMake(midX, midY))];
    }
}

#pragma mark - 设置闪电的分支起点
- (void)setupBranchLightningPoint {
    NSInteger numberLight = arc4random()%2 + 5;
    do {
        CGPoint tempPoint = CGPointFromString(self.pointArr[arc4random()%self.pointArr.count]);
        if ([self.branchLightningStartPointArr containsObject:NSStringFromCGPoint(tempPoint)]) {
            continue;
        } else {
            [self.branchLightningStartPointArr addObject:NSStringFromCGPoint(tempPoint)];
        }
    } while (self.branchLightningStartPointArr.count < numberLight);
}

#pragma mark - 设置闪电分支的起点
- (NSMutableArray *)setupBranchLightningPathPointWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint displace:(CGFloat)displace {
    CGFloat midX = startPoint.x;
    CGFloat midY = startPoint.y;
    NSMutableArray *pathPointArr = [NSMutableArray array];

    //第一个起点
    [pathPointArr addObject:NSStringFromCGPoint(startPoint)];
    NSInteger numPathPoint = arc4random()%20+50;
    
    for (int i = 0; i < numPathPoint; i ++) {
        if (startPoint.x < [UIScreen mainScreen].bounds.size.width/2){
            midX += (arc4random()%3 - 0.5)*displace;
            midY += (arc4random()%5 - 0.5)*displace;
        } else {
            midX -= (arc4random()%3 - 0.5)*displace;
            midY += (arc4random()%5 - 0.5)*displace;
        }
        [pathPointArr addObject:NSStringFromCGPoint(CGPointMake(midX, midY))];
    }
    return pathPointArr;
}

#pragma mark - 设置闪电的路径
- (void)setupLightningPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [self.bezierPathArr addObject:path];
    CGPoint point;
    
    for (NSInteger i = 0; i < self.pointArr.count; i ++) {
        point = CGPointFromString(self.pointArr[i]);
        if (i == 0) {
            //画线,设置起点
            [path moveToPoint:point];
        } else {
            //设置第二个条线的终点,会自动把上一个终点当做起点
            [path addLineToPoint:point];
        }
        
        if ([self.branchLightningStartPointArr containsObject:NSStringFromCGPoint(point)]) {
            NSMutableArray *branchArray = [self setupBranchLightningPathPointWithStartPoint:point endPoint:CGPointMake(point.x + 100, point.y + 100) displace:1];
            UIBezierPath *branchPath = [UIBezierPath bezierPath];
            CGPoint branchPoint;
            for (NSInteger j = 0; j < branchArray.count; j ++) {
                branchPoint = CGPointFromString(branchArray[j]);
                if (j == 0) {
                    //画线,设置起点
                    [branchPath moveToPoint:branchPoint];
                } else {
                    //设置第二个条线的终点,会自动把上一个终点当做起点
                    [branchPath addLineToPoint:branchPoint];
                }
            }
            [self.bezierPathArr addObject:branchPath];
        }
    }
}

#pragma mark - 设置闪电的动画效果
- (void)setupLightningAnimation {
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.2;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.repeatCount = 1;

    //透明度
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 1.0;
    groupAnimation.animations = @[[self opacityForeverAnimation:0.1], pathAnimation,opacityAnimation];
    groupAnimation.autoreverses = NO;
    groupAnimation.repeatCount = 1;
    
    for (int i = 0; i < self.bezierPathArr.count; i ++) {
        UIBezierPath *path = self.bezierPathArr[i];
        CAShapeLayer *pathLayer = [CAShapeLayer layer];
        pathLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        pathLayer.path = path.CGPath;
        pathLayer.strokeColor = [[UIColor whiteColor] CGColor];
        pathLayer.fillColor = nil;
        pathLayer.lineWidth = arc4random() % 15 / 10.0 + 0.5;
        pathLayer.lineJoin = kCALineJoinMiter;
        [self addSublayer:pathLayer];
        [pathLayer addAnimation:groupAnimation forKey:@"kFlashAnimation"];
        
        [UIView animateWithDuration:1.0 delay:0 options:0 animations:^{
            pathLayer.opacity = 0.0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark - 设置 point
- (void)setupPointArray {
    [self.pointArr removeAllObjects];
    NSInteger space = 0;
    for (NSInteger i = 0; i < 1000; i ++) {
        CGPoint point = CGPointMake(50 + (space += 1), arc4random()%5 + 150);
        [self.pointArr addObject:NSStringFromCGPoint(point)];
    }
}

#pragma mark - lazy
- (NSMutableArray *)pointArr {
    if (!_pointArr) {
        _pointArr = [NSMutableArray array];
    }
    return _pointArr;
}

- (NSMutableArray *)branchLightningStartPointArr {
    if (!_branchLightningStartPointArr) {
        _branchLightningStartPointArr = [NSMutableArray array];
    }
    return _branchLightningStartPointArr;
}

- (NSMutableArray *)bezierPathArr {
    if (!_bezierPathArr) {
        _bezierPathArr = [NSMutableArray array];
    }
    return _bezierPathArr;
}

@end
