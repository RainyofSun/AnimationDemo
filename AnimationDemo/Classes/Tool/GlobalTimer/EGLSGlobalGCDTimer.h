//
//  EGLSGlobalGCDTimer.h
//  XiaoYeMa
//
//  Created by EGLS_BMAC on 2019/12/30.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

/// 全局定时器
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EGLSGCDTimerDelegate <NSObject>

/// 倒计时刷新UI
- (void)countDownRefreshUI;

@end

@interface EGLSGlobalGCDTimer : NSObject

/** timerQueue --> 定时器执行任务的线程(默认为主线程) */
@property (nonatomic,strong) dispatch_queue_t timerQueue;
/** timerDelegate */
@property (nonatomic,weak) id<EGLSGCDTimerDelegate> timerDelegate;
/** isResumeTimer */
@property (nonatomic,readonly) BOOL isResumeTimer;

/// 创建定时器
+ (instancetype)GlobalTimerSetUp;
/// 开启定时器
- (void)timerStart;
/// 暂停定时器
- (void)timerSuspend;
/// 销毁定时器
- (void)timerInvaild;

@end

NS_ASSUME_NONNULL_END
