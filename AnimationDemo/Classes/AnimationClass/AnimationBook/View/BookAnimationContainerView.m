//
//  BookAnimationContainerView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "BookAnimationContainerView.h"
#import "PoemView.h"
#import "CustomBasicAnimation.h"

@interface BookAnimationContainerView ()<CustomAnimationDelegate>

/** poemBtn */
@property (nonatomic,strong) UIButton *poemBtn;
/** poemView */
@property (nonatomic,strong) PoemView *poemView;

@end

@implementation BookAnimationContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.poemView.frame = CGRectMake(ScreenWidth - self.poemView.poemSize.width, ScreenHeight - self.poemView.poemSize.height, self.poemView.poemSize.width, self.poemView.poemSize.height);
    CGSize imgSize = self.poemBtn.currentBackgroundImage.size;
    self.poemBtn.frame = CGRectMake(CGRectGetMidX(self.bounds) - imgSize.width * 0.03/2, -imgSize.height * 0.03, imgSize.width * 0.03, imgSize.height * 0.03);
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (CGPoint)centerPoint {
    return self.poemBtn.center;
}

#pragma mark - private methods
- (void)setupUI {
    [self addSubview:self.poemView];
    [self addSubview:self.poemBtn];
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"purpleHalo.png"]];
    [self.poemBtn setBackgroundImage:backImg forState:UIControlStateNormal];
    [self.poemBtn addTarget:self action:@selector(touchPoem:) forControlEvents:UIControlEventTouchUpInside];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.poemView startAnimation];
        [self switchAnimation];
    });
}

- (void)switchAnimation {
    CABasicAnimation *alphaAnimation = [self alphaAnimation];
    CABasicAnimation *rotationAnimation = [self rotationAnimation];
    CABasicAnimation *scaleAnimation = [self scaleAnimation];
    CAAnimationGroup *group = [self groupAnimation:@[alphaAnimation,rotationAnimation,scaleAnimation] durTimes:MAXFLOAT Rep:1];
    [self.poemBtn.layer addAnimation:group forKey:nil];
    CustomBasicAnimation *moveAnimation = [self movePositionFromValue:self.poemBtn.center endValue:CGPointMake((CGRectGetMidX(self.bounds)), ScreenHeight - self.poemBtn.currentBackgroundImage.size.height * 0.03/2)];
    [self.poemBtn.layer addAnimation:moveAnimation forKey:nil];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim {
    CGSize imgSize = self.poemBtn.currentBackgroundImage.size;
    self.poemBtn.frame = CGRectMake(CGRectGetMidX(self.bounds) - imgSize.width * 0.03/2, ScreenHeight - imgSize.height * 0.03, imgSize.width * 0.03, imgSize.height * 0.03);
}

#pragma mark - Target
- (void)touchPoem:(UIButton *)sender {
    ((void (*)(id, SEL))objc_msgSend)((id)[self nearsetVC], @selector(showPoem));
}

#pragma mark - animation
- (CustomBasicAnimation *)movePositionFromValue:(CGPoint)startPoint endValue:(CGPoint)endPoint {
    CustomBasicAnimation *moveAnimation = [CustomBasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.duration = 10;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.fromValue = [NSValue valueWithCGPoint:startPoint];
    moveAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    moveAnimation.animationDelegate = self;
    return moveAnimation;
}

- (CABasicAnimation *)alphaAnimation {
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.duration = 0.3;
    alphaAnimation.removedOnCompletion = NO;
    alphaAnimation.fillMode = kCAFillModeForwards;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:0.3];
    alphaAnimation.toValue = [NSNumber numberWithFloat:1.f];
    alphaAnimation.autoreverses = YES;
    alphaAnimation.repeatCount = MAXFLOAT;
    return alphaAnimation;
}

- (CABasicAnimation *)scaleAnimation {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 5;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.3];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5f];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    return scaleAnimation;
}

- (CABasicAnimation *)rotationAnimation {
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.byValue = @(M_PI * 2);
    animation.duration = 3;
    animation.cumulative = YES;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT;
    return animation;
}

- (CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes {
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = animationAry;
    animation.duration = time;
    animation.repeatCount = repeatTimes;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

#pragma mark - lazy
- (UIButton *)poemBtn {
    if (!_poemBtn) {
        _poemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _poemBtn;
}

- (PoemView *)poemView {
    if (!_poemView) {
        _poemView = [[PoemView alloc] init];
    }
    return _poemView;
}

@end
