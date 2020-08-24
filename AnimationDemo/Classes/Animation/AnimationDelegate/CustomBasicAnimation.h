//
//  CustomBasicAnimation.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CustomAnimationDelegate <NSObject>

@optional;
- (void)animationDidStop:(CAAnimation *)anim;

@end

@interface CustomBasicAnimation : CABasicAnimation <CAAnimationDelegate>

/** animationDelegate */
@property (nonatomic,weak) id<CustomAnimationDelegate> animationDelegate;


@end

NS_ASSUME_NONNULL_END
