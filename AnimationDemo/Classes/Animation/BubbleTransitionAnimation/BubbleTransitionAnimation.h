//
//  BubbleTransitionAnimation.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    BubbleTransitionModel_Present,
    BubbleTransitionModel_Dismiss,
} BubbleTransitionModel;

typedef enum : NSUInteger {
    TransitionAnimationType_Bubble,
    TransitionAnimationType_Roll,
} TransitionAnimationType;

@interface BubbleTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>

/** startPoint */
@property (nonatomic,assign) CGPoint startPoint;
/** duration */
@property (nonatomic,assign) CGFloat duration;
/** transitionModel */
@property (nonatomic,assign) BubbleTransitionModel transitionModel;
/** animationType */
@property (nonatomic,assign) TransitionAnimationType animationType;
/** bubbleColor */
@property (nonatomic,strong) UIColor *bubbleColor;

@end

NS_ASSUME_NONNULL_END
