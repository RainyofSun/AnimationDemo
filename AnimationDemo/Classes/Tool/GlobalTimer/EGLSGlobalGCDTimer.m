//
//  EGLSGlobalGCDTimer.m
//  XiaoYeMa
//
//  Created by EGLS_BMAC on 2019/12/30.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import "EGLSGlobalGCDTimer.h"

static EGLSGlobalGCDTimer *gcdTimer = nil;

@interface EGLSGlobalGCDTimer ()

/** timer */
@property (nonatomic,strong) dispatch_source_t timer;
/** isResumeTimer */
@property (nonatomic,readwrite) BOOL isResumeTimer;

@end

@implementation EGLSGlobalGCDTimer

+ (instancetype)GlobalTimerSetUp {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!gcdTimer) {
            gcdTimer = [[EGLSGlobalGCDTimer alloc] init];
            gcdTimer.timerQueue = dispatch_get_main_queue();
            [gcdTimer addTimerSource];
        }
    });
    return gcdTimer;
}

- (BOOL)willDealloc {
    return NO;
}

#pragma mark - pblic methods
- (void)timerStart {
    if (self.isResumeTimer) {
        NSLog(@"定时器已开启");
        return;
    }
    self.isResumeTimer = YES;
    dispatch_resume(self.timer);
}

- (void)timerSuspend {
    if (self.timer) {
        dispatch_suspend(self.timer);
        self.isResumeTimer = NO;
    }
}

- (void)timerInvaild {
    if (self.timer) {
        long result = dispatch_source_testcancel(self.timer);
        if (result == 0) {
            dispatch_source_cancel(self.timer);
            self.timer = nil;
        } else {
            NSLog(@"定时器已取消");
        }
    } else {
        NSLog(@"定时器完成,已销毁");
    }
}

#pragma mark - private methods
- (void)addTimerSource {
    WEAK_DEFINE(self);
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weak_self.timerDelegate != nil && [weak_self.timerDelegate respondsToSelector:@selector(countDownRefreshUI)]) {
                [weak_self.timerDelegate countDownRefreshUI];
            }
        });
    });
}

#pragma mark - lazy
- (dispatch_source_t)timer {
    if (!_timer) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.timerQueue);
    }
    return _timer;
}
@end
