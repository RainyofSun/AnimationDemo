//
//  UIViewController+Transition.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/7/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "UIViewController+Transition.h"
#import <objc/runtime.h>

@interface UIViewController ()<UINavigationControllerDelegate>

/** percentInteractiveTransition */
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *percentInteractiveTransition;
/** direction */
@property (nonatomic,assign) UIRectEdge direction;

@end

@implementation UIViewController (Transition)

#pragma mark - public methods
- (UITapGestureRecognizer *)appendTapActionWithTargetView:(__kindof UIView *)targetView {
    targetView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGeasture;
    switch (self.transitionOperation) {
        case UINavigationControllerOperationPush:
        {
            tapGeasture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToNextViewController:)];
            [targetView addGestureRecognizer:tapGeasture];
        }
            break;
        case UINavigationControllerOperationPop:
        {
            tapGeasture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popToFromViewController:)];
            [targetView addGestureRecognizer:tapGeasture];
        }
            break;
        default:
            break;
    }
    return tapGeasture;
}

- (UIScreenEdgePanGestureRecognizer *)appendEdgePanActionWithDirection:(UIRectEdge)direction {
    self.view.userInteractionEnabled = YES;
    self.direction = direction;
    UIScreenEdgePanGestureRecognizer *edgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanAction:)];
    edgeGesture.edges = self.direction;
    [self.view addGestureRecognizer:edgeGesture];
    return edgeGesture;
}

#pragma mark - target action
- (void)pushToNextViewController:(UITapGestureRecognizer *)sender {
    if (self.transitionGestureDelegate != nil && [self.transitionGestureDelegate respondsToSelector:@selector(transitionGesturePush)]) {
        [self.transitionGestureDelegate transitionGesturePush];
    } else if (self.targetClass) {
        UIViewController *vc = [[self.targetClass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)popToFromViewController:(UITapGestureRecognizer *)sender {
    if (self.transitionGestureDelegate != nil && [self.transitionGestureDelegate respondsToSelector:@selector(transitionGesturePop)]) {
        [self.transitionGestureDelegate transitionGesturePop];
    } else if (self.targetClass) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)edgePanAction:(UIScreenEdgePanGestureRecognizer *)sender {
    CGFloat progress = [sender translationInView:self.view].x / self.view.frame.size.width;
    if (self.direction == UIRectEdgeRight) {
        progress = -progress;
    }
    
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.percentInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        switch (self.transitionOperation) {
            case UINavigationControllerOperationPush:
                [self pushToNextViewController:nil];
                break;
            case UINavigationControllerOperationPop:
                [self popToFromViewController:nil];
                break;
            default:
                break;
        }
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        [self.percentInteractiveTransition updateInteractiveTransition:progress];
    } else if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
        if (progress > 0.5) {
            [self.percentInteractiveTransition finishInteractiveTransition];
        } else {
            [self.percentInteractiveTransition cancelInteractiveTransition];
        }
        self.percentInteractiveTransition = nil;
    }
}

#pragma mark - setter / getter
- (Class)targetClass {
    return objc_getAssociatedObject(self,@selector(targetClass));
}

- (void)setTargetClass:(Class)targetClass {
    objc_setAssociatedObject(self, @selector(targetClass), targetClass, OBJC_ASSOCIATION_ASSIGN);
}

- (UINavigationControllerOperation)transitionOperation {
    return [objc_getAssociatedObject(self, @selector(transitionOperation)) integerValue];
}

- (void)setTransitionOperation:(UINavigationControllerOperation)transitionOperation {
    objc_setAssociatedObject(self, @selector(transitionOperation), @(transitionOperation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<TransitionGestureDelegate>)transitionGestureDelegate {
    return objc_getAssociatedObject(self, @selector(transitionGestureDelegate));
}

- (void)setTransitionGestureDelegate:(id<TransitionGestureDelegate>)transitionGestureDelegate {
    objc_setAssociatedObject(self, @selector(transitionGestureDelegate), transitionGestureDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIPercentDrivenInteractiveTransition *)percentInteractiveTransition {
    return objc_getAssociatedObject(self, @selector(percentInteractiveTransition));
}

- (void)setPercentInteractiveTransition:(UIPercentDrivenInteractiveTransition *)percentInteractiveTransition {
    objc_setAssociatedObject(self, @selector(percentInteractiveTransition), percentInteractiveTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIRectEdge)direction {
    return [objc_getAssociatedObject(self, @selector(direction)) integerValue];
}

- (void)setDirection:(UIRectEdge)direction {
    objc_setAssociatedObject(self, @selector(direction), @(direction), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
