//
//  AppDelegate+SystemObserver.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AppDelegate+SystemObserver.h"

@implementation AppDelegate (SystemObserver)

- (void)addSystemObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appActive:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)appActive:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] postNotificationName:AppEnterForegroundNotification object:nil];
}

@end
