//
//  BookAnimationContainerView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "BookAnimationContainerView.h"
#import "PoemView.h"

@interface BookAnimationContainerView ()

/** poemBtn */
@property (nonatomic,strong) UIButton *poemBtn;
/** poemView */
@property (nonatomic,strong) PoemView *poemView;

@end

@implementation BookAnimationContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.poemView.frame = CGRectMake(ScreenWidth - self.poemView.poemSize.width, ScreenHeight - self.poemView.poemSize.height, self.poemView.poemSize.width, self.poemView.poemSize.height);
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - private methods
- (void)setupUI {
    [self addSubview:self.poemView];
    [self addSubview:self.poemBtn];
    [self.poemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    self.poemBtn.backgroundColor = [UIColor redColor];
    [self.poemBtn addTarget:self action:@selector(touchPoem:) forControlEvents:UIControlEventTouchUpInside];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.poemView startAnimation];
    });
}

#pragma mark - Target
- (void)touchPoem:(UIButton *)sender {
    ((void (*)(id, SEL))objc_msgSend)((id)[self nearsetVC], @selector(showPoem));
}

#pragma mark - lazy
- (UIButton *)poemBtn {
    if (!_poemBtn) {
        _poemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _poemBtn;
}

- (PoemView *)poemView {
    if (!_poemView) {
        _poemView = [[PoemView alloc] init];
    }
    return _poemView;
}

@end
