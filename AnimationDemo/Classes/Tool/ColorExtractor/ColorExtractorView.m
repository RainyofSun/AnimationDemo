//
//  ColorExtractorView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "ColorExtractorView.h"
#import "ColorValueView.h"
#import <math.h>

/** colorViewWidth 宽度*/
#define ColorWidth (ScreenWidth * 1)
/** color 圆环是半径的倍速 可修改*/
#define Multiple 0.45    // 0.32
/** 圆形半径 */
#define CornerRadius (ColorWidth * Multiple)     // 0.32
/** 圆形外边距 */
#define OutsideMargin (ColorWidth * (0.5 - Multiple))     // 0.18
/** 小球圆心距离大圆中心在 X 方向的距离 */
#define ViewXMargin(angle) (cosf(AngleToRadian(angle)) * CornerRadius)
/** 内容视图距离顶部的距离 */
#define ContentViewTopMargin 0
/** 角度换算弧度 π */
#define AngleToRadian(angle)  (M_PI * angle / 180.0 )
/** 弧度换算角度 ° */
#define RadianToAngle(radian) (180.0 * radian / M_PI)

@interface ColorExtractorView ()

/** 圆心point */
@property (nonatomic, assign, readonly) CGPoint centerPoint;
/** 默认位置 */
@property (nonatomic, assign, readonly) CGPoint originPoint;
/** 盛放环形颜色的view */
@property (nonatomic, strong, nonnull) UIView *bgContentView;
/** 指示器圆球view */
@property (nonatomic, strong) UIView *valveView;
/** 指示器圆球的变动的 rect */
@property (nonatomic, assign) CGRect valveRect;
/** 标记初始触摸是否在指示球上 */
@property (nonatomic, assign) BOOL spot;
/** 环形渐变圈 */
@property (nonatomic, strong) UIImageView *colorImageView;

@end

@implementation ColorExtractorView

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
+ (instancetype)instanceWithView:(UIView *)view topDistanceWithSuperView:(CGFloat)distance {
    ColorExtractorView *colorView = [[ColorExtractorView alloc] initWithFrame:CGRectMake(0.5 * (ScreenWidth - ColorWidth), distance, ColorWidth, ColorWidth + ContentViewTopMargin)];
    [view addSubview:colorView];
    return colorView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self colorViewInit];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point  = [touch locationInView:self];
    
    point = CGPointMake(point.x, point.y - ContentViewTopMargin * 2);
    
    BOOL container = CGRectContainsPoint(self.valveRect, point);
    if (container) {
        self.spot = YES;
        [self moveToValueViewWithPoint:point];
    } else {
        self.spot = NO;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    point = CGPointMake(point.x, point.y + ContentViewTopMargin);
    if (self.spot) {
        [self moveToValueViewWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.spot = NO;
}

#pragma mark - private methods
- (void)initializationData {
    _centerPoint = CGPointMake(_bgContentView.center.x, _bgContentView.center.y - ContentViewTopMargin);
    
    _originPoint = CGPointMake(_centerPoint.x - ViewXMargin(45) , _centerPoint.y - ViewXMargin(45) + ContentViewTopMargin);
}

- (void)colorViewInit {
    
    self.backgroundColor = [UIColor whiteColor];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, ContentViewTopMargin, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - ContentViewTopMargin)];
    [self addSubview:bgView];
    self.bgContentView = bgView;
    
    [self initializationData];
    
    UIImage *image = [UIImage imageNamed:@"ic_color_pick_circle"];
    UIImageView *colorImgView = [[UIImageView alloc] initWithImage:image];
    colorImgView.frame = CGRectMake(0, 0, CornerRadius * 2 + 10, CornerRadius * 2 + 10);
    colorImgView.center = bgView.center;
    self.colorImageView = colorImgView;
    [bgView addSubview:colorImgView];
    
    self.valveView = [ColorValueView valveView:bgView];
    self.valveView.center = self.originPoint;
    
    self.valveRect = self.valveView.frame;
}

- (void)moveToValueViewWithPoint:(CGPoint)point {
    CGFloat angle = angleBetweenLines(point, CGPointMake(self.centerPoint.x, self.centerPoint.y + ContentViewTopMargin), CGPointMake(self.centerPoint.x, self.originPoint.y));
    
    CGPoint currentPoint = [ColorValueView valveTheCenterWithCircleRadius:CornerRadius moveAngle:angle point:point centerPoint:self.centerPoint];
    if (isnan(currentPoint.x) || isnan(currentPoint.y)) {
        return;
    } else {
        self.valveView.center = CGPointMake(currentPoint.x, currentPoint.y + ContentViewTopMargin);;
    }
    
    self.valveRect = CGRectMake(currentPoint.x - self.valveView.frame.size.width/2, currentPoint.y - self.valveView.frame.size.height/2, self.valveView.frame.size.width, self.valveView.frame.size.height);
    
    CGPoint tempPoint = CGPointMake(currentPoint.x - OutsideMargin + 5, currentPoint.y - OutsideMargin + 5);
    
    UIColor *selectorColor = [ColorValueView colorAtPixel:tempPoint withImage:self.colorImageView.image imageWidth:CornerRadius * 2 + 10];
    
    self.valveView.backgroundColor = self.bgContentView.backgroundColor = selectorColor;
    if (self.colorDelegate != nil && [self.colorDelegate respondsToSelector:@selector(selectColor:)]) {
        [self.colorDelegate selectColor:selectorColor];
    }
}

/**
 获取两条线的夹角

 @param line1Start 当前移动的点
 @param lineEnd Y 圆心点
 @param line2Start 当前移动点投影到 Y 轴上的点
 @return 夹角
 */
CGFloat angleBetweenLines(CGPoint line1Start, CGPoint lineEnd, CGPoint line2Start) {
    CGFloat a = lineEnd.x - line1Start.x;
    CGFloat b = lineEnd.y - line1Start.y;
    
    CGFloat c = lineEnd.x - line2Start.x;
    CGFloat d = lineEnd.y - line2Start.y;
    
    CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));

    return RadianToAngle(rads);
}

@end
