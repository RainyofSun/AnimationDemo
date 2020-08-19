//
//  UIView+GetSuperVc.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "UIView+GetSuperVc.h"

@implementation UIView (GetSuperVc)

- (UIViewController *)nearsetVC {
    UIViewController *viewController = nil;
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController*)nextResponder;
            break;
        }
    }
    return viewController;
}

@end
