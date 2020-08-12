//
//  UIApplication+TopController.h
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/22.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TopMostControllerProtocol <NSObject>

- (UIViewController *)visibleViewController;

@end

@interface UINavigationController (TopController) <TopMostControllerProtocol>

@end

@interface UITabBarController (TopController) <TopMostControllerProtocol>

@end

@interface UIApplication (TopController)

+ (UIViewController *)topMostController;

@end

NS_ASSUME_NONNULL_END
