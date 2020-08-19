//
//  CherryTreeAnimationView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/5.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "CherryTreeAnimationView.h"

@implementation CherryTreeAnimationView

- (instancetype)init {
    if (self = [super init]) {
        [self cherryTreesAnimationInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self cherryTreesAnimationInit];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)animationStart {
    [super animationStart];
    [self cherryTreeAnimation];
}

#pragma mark - private methods
- (void)cherryTreesAnimationInit {
    self.layer.contents = (id)[UIImage imageNamed:@"cherrytrees"].CGImage;
    self.clipsToBounds = YES;
    self.layer.contentsGravity = kCAGravityResizeAspectFill;
}

- (void)cherryTreeAnimation {
    CAEmitterLayer *cherryTreeLayer = [CAEmitterLayer layer];
    cherryTreeLayer.emitterPosition = CGPointMake(CGRectGetMidX(self.bounds), -30);
    cherryTreeLayer.emitterSize     = CGSizeMake(CGRectGetWidth(self.bounds), 0);
    cherryTreeLayer.emitterMode     = kCAEmitterLayerOutline;
    cherryTreeLayer.emitterShape    = kCAEmitterLayerLine;
    cherryTreeLayer.shadowOpacity   = 1;
    cherryTreeLayer.shadowRadius    = 8;    // 阴影化开的程度
    cherryTreeLayer.shadowOffset    = CGSizeMake(3, 3);
    cherryTreeLayer.shadowColor     = [UIColor whiteColor].CGColor;
    
    CAEmitterCell *cell1 = [CAEmitterCell emitterCell];
    cell1.contents       = (__bridge id)[UIImage imageNamed:@"petals"].CGImage;
    cell1.scale          = 0.02;
    cell1.scaleRange     = 0.5;
    cell1.birthRate      = 7.f;
    cell1.lifetime       = 80;
    cell1.alphaSpeed     = -0.01;
    cell1.velocity       = 40;
    cell1.velocityRange  = 60;
    cell1.emissionRange  = M_PI;    // 花瓣掉落角度范围
    cell1.spin           = M_PI_4;  // 花瓣旋转角度
    
    cherryTreeLayer.emitterCells = @[cell1];
    [self.layer addSublayer:cherryTreeLayer];
}

@end
