//
//  UIApplication+TopController.m
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/22.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import "UIApplication+TopController.h"

@implementation UINavigationController (TopController)

- (UIViewController *)visibleViewController{
    return self.topViewController;
}

@end

@implementation UITabBarController (TopController)

- (UIViewController *)visibleViewController {
    return self.selectedViewController;
}

@end

@implementation UIApplication (TopController)

+ (UIViewController *)topMostController {
    // Start with the window rootViewController
    UIViewController *topController = ((UIWindow *)[[UIApplication sharedApplication].windows firstObject]).rootViewController;
    
    // Is there any modal view on top?
    topController = [self getModalViewControllerOfControllerIfExists:topController];
    
    // Keep reference to the old controller while looping
    UIViewController *oldTopController = nil;
    
    // Loop them all
    while ([topController conformsToProtocol:@protocol(TopMostControllerProtocol)] && oldTopController != topController) {
        oldTopController = topController;
        topController = [(UIViewController < TopMostControllerProtocol > *) topController visibleViewController];
        // Again, check for any modal controller
        topController = [self getModalViewControllerOfControllerIfExists:topController];
    }
    
    return topController;
}

+ (UIViewController *)getModalViewControllerOfControllerIfExists:(UIViewController *)controller {
    UIViewController *toReturn = nil;
    // modalViewController is deprecated since iOS 6, so use presentedViewController instead
    if ([controller respondsToSelector:@selector(presentedViewController)]) toReturn = [controller performSelector:@selector(presentedViewController)];
    else toReturn = [controller performSelector:@selector(modalViewController)];
    
    // If no modal view controller found, return the controller itself
    if (!toReturn) toReturn = controller;
    return toReturn;
}

@end
