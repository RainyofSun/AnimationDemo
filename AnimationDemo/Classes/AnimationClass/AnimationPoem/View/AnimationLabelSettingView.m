//
//  AnimationLabelSettingView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationLabelSettingView.h"

@interface AnimationLabelSettingView ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UILabel *durationTime;
@property (weak, nonatomic) IBOutlet UILabel *delayTime;
@property (weak, nonatomic) IBOutlet UISegmentedControl *animationTypeSegment;
@property (weak, nonatomic) IBOutlet UIButton *animationTypeBtn;

/** settingViewH */
@property (nonatomic,readwrite) CGFloat settingViewH;
/** selectedSegment */
@property (nonatomic,assign) NSInteger selectedSegment;
/** animationType */
@property (nonatomic,assign) NSInteger animationType;

/** animationTypeArray */
@property (nonatomic,strong) NSArray *animationTypeArray;

@end

@implementation AnimationLabelSettingView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.settingViewH = CGRectGetHeight(self.bounds);
    self.selectedSegment = 0;
    self.animationType = 0;
    self.animationTypeArray = @[@"Throw", @"Shapeshift", @"Default", @"Duang", @"Fall", @"Alpha", @"Flyin", @"Blur", @"Reveal", @"Spin", @"Dash"];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)setAnimationStyle:(NSInteger)animationStyle withAnimationType:(NSInteger)animationType {
    self.selectedSegment = animationStyle;
    self.animationType = animationType;
    [self.animationTypeSegment setSelectedSegmentIndex:self.selectedSegment];
    [self.animationTypeBtn setTitle:self.animationTypeArray[self.animationType] forState:UIControlStateNormal];
}

#pragma mark - Tatget
- (IBAction)touchSettingBtn:(UIButton *)sender {
    if (sender.tag == 1) {
        ((void (*)(id, SEL, NSNumber *,NSNumber *,NSNumber *,NSNumber *))objc_msgSend)((id)self.superview, @selector(animationLabelStyle:duration:delayTime:animationType:), [NSNumber numberWithFloat:self.selectedSegment],[NSNumber numberWithFloat:self.durationTime.text.floatValue],[NSNumber numberWithFloat:self.delayTime.text.floatValue],[NSNumber numberWithInteger:self.animationType]);
    }
    WEAK_DEFINE(self);
    [self hide:^{
        weak_self.selectedSegment = 0;
        weak_self.animationType = 0;
    }];
}

- (IBAction)selectAnimationEffect:(UIButton *)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Throw", @"Shapeshift", @"Default", @"Duang", @"Fall", @"Alpha", @"Flyin", @"Blur", @"Reveal", @"Spin", @"Dash", nil];
    [sheet showInView:self];
}

- (IBAction)touchSegment:(UISegmentedControl *)sender {
    self.selectedSegment = sender.selectedSegmentIndex + 1;
}

- (IBAction)animationTimeChange:(UISlider *)sender {
    self.durationTime.text = [NSString stringWithFormat:@"%.1f",sender.value];
}

- (IBAction)animationDelayChange:(UISlider *)sender {
    self.delayTime.text = [NSString stringWithFormat:@"%.2f",sender.value];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex > actionSheet.numberOfButtons) {
        return;
    }
    self.animationType = buttonIndex + 10;
    [self.animationTypeBtn setTitle:self.animationTypeArray[buttonIndex] forState:UIControlStateNormal];
}

@end
