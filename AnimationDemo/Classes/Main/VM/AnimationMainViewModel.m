//
//  AnimationMainViewModel.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/7/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationMainViewModel.h"
#import "AnimationBaseNavViewController.h"
#import "AnimationStartViewController.h"

@implementation AnimationMainViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadNav:(UIViewController *)vc {
    AnimationBaseNavViewController *animationNav = [[AnimationBaseNavViewController alloc] initWithRootViewController:[[AnimationStartViewController alloc] initWithNibName:@"AnimationStartViewController" bundle:nil]];
    [vc.view addSubview:animationNav.view];
    [vc addChildViewController:animationNav];
    animationNav.view.frame = vc.view.frame;
}

@end
