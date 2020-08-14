//
//  DrawWordsAnimationLayer.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "DrawWordsAnimationLayer.h"

@interface DrawWordsAnimationLayer ()<CAAnimationDelegate>

@property (nonatomic,retain)CAShapeLayer *pathLayer;
@property (nonatomic,retain)CAShapeLayer *heartPathLayer;
@property (nonatomic,retain)CALayer *penLayer;

@end

@implementation DrawWordsAnimationLayer

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)createAnimationLayerWithWords:(NSString *)animationWords animationRect:(CGRect)rect animationWordsFont:(UIFont *)font strokeColor:(UIColor *)strokeColor {
    self.frame = rect;
    CTFontRef wordsFont = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, NULL);
    CGMutablePathRef letters = CGPathCreateMutable();
    
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)wordsFont,kCTFontAttributeName, nil];
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:animationWords attributes:attrs];
    
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attStr);
    CFArrayRef runArr = CTLineGetGlyphRuns(line);
    
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArr); runIndex ++) {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArr, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex ++) {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    
    CFRelease(line);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGPathRelease(letters);
    CFRelease(wordsFont);
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height - 230);
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [strokeColor CGColor];
    pathLayer.fillColor = nil;//填充字体颜色,如果设置了就会提前出现
    pathLayer.lineWidth = 1.f;
    pathLayer.lineJoin = kCALineJoinBevel;
    [self addSublayer:pathLayer];
    self.pathLayer = pathLayer;
    
    UIImage *penImage = [UIImage imageNamed:@"pen"];
    CALayer *penLayer = [CALayer layer];
    penLayer.contents = (id)penImage.CGImage;
    penLayer.anchorPoint = CGPointZero;
    penLayer.frame = CGRectMake(0, 0, penImage.size.width, penImage.size.height);
    [pathLayer addSublayer:penLayer];
    self.penLayer = penLayer;
    
    [self.pathLayer removeAllAnimations];
    [self.penLayer removeAllAnimations];
    
    self.penLayer.hidden = NO;
    
    [self drawHeart:rect];
//    [self drawHeart:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width * 0.7, rect.size.height * 0.8)];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 5.f;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    CAKeyframeAnimation *penAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    penAnimation.duration = 5.f;
    penAnimation.path = self.pathLayer.path;
    penAnimation.calculationMode = kCAAnimationPaced;
    penAnimation.delegate = self;
    [self.penLayer addAnimation:penAnimation forKey:@"strokeEnd"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.pathLayer removeAllAnimations];
        [self.penLayer removeAllAnimations];
        [self.heartPathLayer removeAllAnimations];
        [self.pathLayer removeFromSuperlayer];
        [self.penLayer removeFromSuperlayer];
        [self.heartPathLayer removeFromSuperlayer];
        self.pathLayer = nil;
        self.penLayer = nil;
        self.heartPathLayer = nil;
        [self removeFromSuperlayer];
    });
}

- (void)drawHeart:(CGRect)rect {
    CGFloat spaceWidth = 20.f;
    CGFloat radius = MIN((CGRectGetWidth(rect) - spaceWidth*2)/4, (CGRectGetHeight(rect) - spaceWidth*2)/4);
    
    CGFloat heartLineW = 5.f;
    CGColorRef heartColor = HexColor(0xe11cda).CGColor;
    
    // 左侧圆心 位于左侧边距+半径宽度
    CGPoint letCenter = CGPointMake(spaceWidth + radius, radius /2);
    // 右侧圆心 位于左侧圆心两个半径
    CGPoint rightCenter = CGPointMake(spaceWidth + radius * 3, radius/2);
    
    // 左侧半圆
    UIBezierPath *heartLine = [UIBezierPath bezierPath];
    [heartLine addArcWithCenter:letCenter radius:radius startAngle:0 endAngle:M_PI clockwise:NO];
    //曲线连接到新的底部顶点 为了弧线的效果，控制点，坐标x为总宽度减spaceWidth，刚好可以相切，平滑过度 y可以根据需要进行调整，y越大，所画出来的线越接近内切圆弧
    [heartLine addQuadCurveToPoint:CGPointMake(rect.size.width/2, rect.size.height - spaceWidth * 6) controlPoint:CGPointMake(spaceWidth, rect.size.height * 0.3)];
    
    CAShapeLayer *heartPathLayer = [CAShapeLayer layer];
    heartPathLayer.path = heartLine.CGPath;
    heartPathLayer.strokeColor = heartColor;
    heartPathLayer.fillColor = nil;
    heartPathLayer.lineWidth = heartLineW;
    heartPathLayer.lineJoin = kCALineJoinRound;
    [self addSublayer:heartPathLayer];
    
    CABasicAnimation *heartPathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    heartPathAnimation.duration = 5.f;
    heartPathAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    heartPathAnimation.toValue = [NSNumber numberWithFloat:1.f];
    [heartPathLayer addAnimation:heartPathAnimation forKey:@"strokeEnd"];
    
    // 右侧半圆
    UIBezierPath *heartRightLine = [UIBezierPath bezierPath];
    [heartRightLine addArcWithCenter:rightCenter radius:radius startAngle:M_PI endAngle:0 clockwise:YES];
    [heartRightLine addQuadCurveToPoint:CGPointMake(rect.size.width/2, rect.size.height - spaceWidth * 6) controlPoint:CGPointMake(rect.size.width - spaceWidth, rect.size.height * 0.3)];
    
    CAShapeLayer *heartRightLayer = [CAShapeLayer layer];
    heartRightLayer.path = heartRightLine.CGPath;
    heartRightLayer.strokeColor = heartColor;
    heartRightLayer.fillColor = nil;
    heartRightLayer.lineWidth = heartLineW;
    heartRightLayer.lineJoin = kCALineJoinRound;
    [self addSublayer:heartRightLayer];
    
    CABasicAnimation *heartRightAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    heartRightAnimation.duration = 5.f;
    heartRightAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    heartRightAnimation.toValue = [NSNumber numberWithFloat:1.f];
    [heartRightLayer addAnimation:heartRightAnimation forKey:@"strokeEnd"];
}

@end
