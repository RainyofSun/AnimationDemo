//
//  NSObject+Observer.h
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/23.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Observer)

- (void)EGLS_RemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;
- (void)EGLS_AddLEDObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end

NS_ASSUME_NONNULL_END
