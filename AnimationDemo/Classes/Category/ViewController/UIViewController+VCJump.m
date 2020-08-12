//
//  UIViewController+VCJump.m
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/26.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import "UIViewController+VCJump.h"
#import "AnimationBaseNavViewController.h"
#import "UIApplication+TopController.h"

@implementation UIViewController (VCJump)

- (void)pushVC:(id)toVc {
    if ([toVc isKindOfClass:[NSString class]]) {
        Class toVCClass = NSClassFromString(toVc);
        if (toVCClass) {
            [self.navigationController pushViewController:[[toVCClass alloc] init] animated:YES];
        }
    } else if ([toVc isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:(UIViewController *)toVc animated:YES];
    }
}

- (void)presentVC:(id)toVc {
    if ([toVc isKindOfClass:[NSString class]]) {
        Class presentVCClass = NSClassFromString(toVc);
        if (presentVCClass) {
            UIViewController *vc = [[presentVCClass alloc] init];
            vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
            [self presentViewController:vc animated:YES completion:nil];
        }
    } else if ([toVc isKindOfClass:[UIViewController class]]) {
        UIViewController *presentVC = (UIViewController *)toVc;
        presentVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:presentVC animated:YES completion:nil];
    }
}

- (void)presentNavVC:(id)navVc {
    if ([navVc isKindOfClass:[NSString class]]) {
        Class presentVCClass = NSClassFromString(navVc);
        if ([[UIApplication topMostController] isKindOfClass:[presentVCClass class]]) {
            NSLog(@"拦截二次弹窗");
            return;
        }
        if (presentVCClass) {
            AnimationBaseNavViewController *nav = [[AnimationBaseNavViewController alloc] initWithRootViewController:[[presentVCClass alloc] init]];
            [self presentViewController:nav animated:YES completion:nil];
        }
    } else if ([navVc isKindOfClass:[UIViewController class]]) {
        AnimationBaseNavViewController *nav = [[AnimationBaseNavViewController alloc] initWithRootViewController:navVc];
        nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.definesPresentationContext = YES;
        [self presentViewController:nav animated:YES completion:nil];
    }

}



@end
