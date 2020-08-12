//
//  NSObject+Observer.m
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/23.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import "NSObject+Observer.h"
#import <objc/runtime.h>

@implementation NSObject (Observer)

// 交换后的方法
- (void)EGLS_RemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    if ([self observerKeyPath:keyPath observer:observer]) {
        [self removeObserver:observer forKeyPath:keyPath];
    } else {
        NSLog(@"监听已经移除");
    }
}

// 交换后的方法
- (void)EGLS_AddLEDObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    if (![self observerKeyPath:keyPath observer:observer]) {
        [self addObserver:observer forKeyPath:keyPath options:options context:context];
    } else {
        NSLog(@"监听已经添加");
    }
}


// 进行检索获取Key
- (BOOL)observerKeyPath:(NSString *)key observer:(id )observer
{
    id info = self.observationInfo;
    NSArray *array = [info valueForKey:@"_observances"];
    for (id objc in array) {
        id Properties = [objc valueForKeyPath:@"_property"];
        id newObserver = [objc valueForKeyPath:@"_observer"];
        
        NSString *keyPath = [Properties valueForKeyPath:@"_keyPath"];
        if ([key isEqualToString:keyPath] && [newObserver isEqual:observer]) {
            return YES;
        }
    }
    return NO;
}

@end
