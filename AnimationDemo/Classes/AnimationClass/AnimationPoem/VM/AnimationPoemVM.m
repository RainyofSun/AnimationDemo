//
//  AnimationPoemVM.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationPoemVM.h"
#import "AnimationPoemView.h"

@interface AnimationPoemVM ()

/** poemView */
@property (nonatomic,strong) AnimationPoemView *poemView;

@end

@implementation AnimationPoemVM

- (void)dealloc {
    [self.poemView removeFromSuperview];
    self.poemView = nil;
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)setupPoemView:(UIViewController *)poemView {
    [poemView.view addSubview:self.poemView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.poemView.frame = CGRectMake(0, 0, poemView.view.frame.size.width, poemView.view.frame.size.height);
    });
}

#pragma mark - lazy
- (AnimationPoemView *)poemView {
    if (!_poemView) {
        _poemView = [[AnimationPoemView alloc] init];
    }
    return _poemView;
}

@end
