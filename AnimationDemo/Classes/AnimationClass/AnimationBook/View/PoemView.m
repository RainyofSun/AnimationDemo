//
//  PoemView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "PoemView.h"

@interface PoemView ()

/** poemBtn */
@property (nonatomic,strong) UIButton *poemBtn;

@end

@implementation PoemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - private methods
- (void)setupUI {
    [self addSubview:self.poemBtn];
    [self.poemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    self.poemBtn.backgroundColor = [UIColor redColor];
    [self.poemBtn addTarget:self action:@selector(touchPoem:) forControlEvents:UIControlEventTouchUpInside];
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

@end
