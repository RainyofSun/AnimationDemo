//
//  BrushWidthSliderView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "BrushWidthSliderView.h"

@interface BrushWidthSliderView ()

/** brushWidth */
@property (nonatomic,assign) CGFloat brushWidth;

@end

@implementation BrushWidthSliderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.frame = CGRectMake(0, ScreenHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)showBrushWidthView {
    [self show:AnimationDirection_Bottom];
}

#pragma mark - Target
- (IBAction)touchBrushViewBtn:(UIButton *)sender {
    if (sender.tag == 1) {
        ((void (*)(id, SEL, NSNumber *))objc_msgSend)((id)self.superview, @selector(ChangeBrushWidth:), [NSNumber numberWithFloat:self.brushWidth]);
    }
    WEAK_DEFINE(self);
    [self hide:^{
        [weak_self removeFromSuperview];
    }];
}

- (IBAction)brushWidthChanged:(UISlider *)sender {
    self.brushWidth = sender.value;
}

@end
