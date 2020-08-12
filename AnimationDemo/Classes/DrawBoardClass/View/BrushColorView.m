//
//  BrushColorView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "BrushColorView.h"
#import "ColorExtractorView.h"

@interface BrushColorView ()<ColorSelectorDelegate>

/** colorExtractorView */
@property (nonatomic,strong) ColorExtractorView *colorExtractorView;
/** sureBtn */
@property (nonatomic,strong) UIButton *sureBtn;
/** cancelBtn */
@property (nonatomic,strong) UIButton *cancelBtn;
/** selectColor */
@property (nonatomic,strong) UIColor *selectColor;

@end

@implementation BrushColorView

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (instancetype)init {
    if (self = [super init]) {
        [self brushColorInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self brushColorInit];
    }
    return self;
}

#pragma mark - public methods
- (void)showColorView {
    [self show:AnimationDirection_Bottom];
}

#pragma mark - Target
- (void)touchSelectColorBtn:(UIButton *)sender {
    if (sender.tag == 1) {
        ((void (*)(id, SEL, UIColor *))objc_msgSend)((id)self.superview, @selector(ChangeBrushColor:), self.selectColor);
    }
    WEAK_DEFINE(self);
    [self hide:^{
        weak_self.colorExtractorView.colorDelegate = nil;
        [weak_self.colorExtractorView removeFromSuperview];
        weak_self.colorExtractorView = nil;
        [weak_self removeFromSuperview];
    }];
}

#pragma mark - ColorSelectorDelegate
- (void)selectColor:(UIColor *)color {
    self.selectColor = color;
}

#pragma mark - private methods
- (void)brushColorInit {
    self.backgroundColor = [UIColor whiteColor];
    
    self.colorExtractorView = [ColorExtractorView instanceWithView:self topDistanceWithSuperView:60];
    self.colorExtractorView.colorDelegate = self;
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.sureBtn.frame = CGRectMake(20, 10, 60, 40);
    self.sureBtn.tag = 1;
    [self.sureBtn addTarget:self action:@selector(touchSelectColorBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.frame = CGRectMake(ScreenWidth - 60, 10, 60, 40);
    [self.cancelBtn addTarget:self action:@selector(touchSelectColorBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.sureBtn];
    [self addSubview:self.cancelBtn];
}

@end
