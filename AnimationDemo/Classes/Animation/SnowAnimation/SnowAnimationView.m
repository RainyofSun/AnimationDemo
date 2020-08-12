//
//  SnowAnimationView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/4.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "SnowAnimationView.h"

@interface SnowAnimationView ()

/** displayLink */
@property (nonatomic,strong) CADisplayLink *displayLink;
/** snowImg */
@property (nonatomic,strong) UIImage *snowImg;

@end

@implementation SnowAnimationView

- (void)dealloc {
    [self freeDisplayLink];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (instancetype)init {
    if (self = [super init]) {
        [self snowAnimationInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self snowAnimationInit];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self freeDisplayLink];
    [self removeFromSuperview];
}

#pragma mark - public methods
- (void)startSnowAnimationWithAnimationType:(SnowAnimationType)animatonType {
    if (animatonType == SnowAnimationType_LayerAnimation) {
        [self layerAnimation];
    } else if (animatonType == SnowAnimationType_EmitterAnimation) {
        [self emitterAnimation];
    }
}

#pragma mark - private methods
- (void)snowAnimationInit {
    self.layer.contents = (id)[UIImage imageNamed:@"snowbg"].CGImage;
    self.layer.contentsGravity = kCAGravityResizeAspectFill;
    self.snowImg = [UIImage imageNamed:@"snow"];
}

// 粒子动画 -- 每次随机生成固定大小的8个雪花粒子,显示效果并不是很好
- (void)emitterAnimation {
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.frame = CGRectMake(0, -100, self.width, 100);
    emitterLayer.emitterSize = CGSizeMake(self.width, 100);
    emitterLayer.emitterPosition = CGPointMake(self.width / 2, 0);
    emitterLayer.emitterMode = kCAEmitterLayerOutline;
    emitterLayer.emitterShape = kCAEmitterLayerLine;
    [self.layer addSublayer:emitterLayer];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 8; i ++) {
        CAEmitterCell *cell1 = [CAEmitterCell emitterCell];
        cell1.birthRate = 2.0f;
        cell1.lifetime = 60.0f;
        cell1.velocity = arc4random_uniform(10);
        cell1.yAcceleration = arc4random_uniform(60);
        cell1.spin = 2.0f;
        cell1.spinRange = 3.0f;
        cell1.scale = arc4random_uniform(60)/100.0;
        cell1.contents = (__bridge id _Nullable)([UIImage imageNamed:@"snow"].CGImage);
        [tempArray addObject:cell1];
    }
    emitterLayer.emitterCells = tempArray;
}

// 使用Layer层进行动画处理 -- 随机生成不同大小的雪花粒子
- (void)layerAnimation {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(snowAnimation:)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)snowAnimation:(CADisplayLink *)displayLink {
    CALayer *tempLayer = [CALayer layer];
    tempLayer.contents = (id)self.snowImg.CGImage;
    tempLayer.contentsGravity = kCAGravityResizeAspect;
    tempLayer.size = self.snowImg.size;
    CGSize winSize = self.bounds.size;
    
    CGFloat x = arc4random_uniform(winSize.width);
    CGFloat y = - tempLayer.frame.size.height;
    tempLayer.center = CGPointMake(x, y);
    [self.layer addSublayer:tempLayer];
    CGFloat scale = arc4random_uniform(60)/100.0;
    tempLayer.transform = CATransform3DMakeScale(scale, scale, 0);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CATransaction begin];
        [CATransaction setAnimationDuration:arc4random_uniform(10)];
        [CATransaction setCompletionBlock:^{
            [tempLayer removeFromSuperlayer];
        }];

        CGFloat toX = arc4random_uniform(winSize.width);
        CGFloat toY = tempLayer.frame.size.height * 0.5 + self.height;

        tempLayer.center = CGPointMake(toX, toY);
        tempLayer.transform = CATransform3DRotate(tempLayer.transform, arc4random_uniform(M_PI * 2),0 ,0 ,1);
        tempLayer.opacity = 0.5;

        [CATransaction commit];
    });
}

- (void)freeDisplayLink {
    if (_displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
        NSLog(@"定时器销毁");
    }
}

@end
