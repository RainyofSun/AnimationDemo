//
//  UIViewController+Transition.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/7/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TransitionGestureDelegate <NSObject>

@optional;
- (void)transitionGesturePush;
- (void)transitionGesturePop;

@end

@interface UIViewController (Transition)

/** targetClass */
@property (nonatomic,assign) Class targetClass;
/** transitionOperation */
@property (nonatomic,assign) UINavigationControllerOperation transitionOperation;

// 当需要添加下面的两个手势时，需要实现delegate (若只是简单的push/pop则不需要实现delegate)
/** transitionGestureDelegate */
@property (nonatomic,weak) id<TransitionGestureDelegate> transitionGestureDelegate;

- (UITapGestureRecognizer *)appendTapActionWithTargetView:(__kindof UIView *)targetView;
- (UIScreenEdgePanGestureRecognizer *)appendEdgePanActionWithDirection:(UIRectEdge)direction;

@end

NS_ASSUME_NONNULL_END
