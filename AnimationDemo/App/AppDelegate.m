//
//  AppDelegate.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/7/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AppDelegate.h"
#import "AnimationMainViewController.h"
#import "AppDelegate+SystemObserver.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self addSystemObserver];
    [self initRootVC];
    return YES;
}

#pragma mark - private methods
- (void)initRootVC {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[AnimationMainViewController alloc] initWithNibName:@"AnimationMainViewController" bundle:nil];
}

@end
