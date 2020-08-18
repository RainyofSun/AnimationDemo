//
//  AnimationStartVM.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/3.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationStartVM.h"
#import "UIViewController+BookCoverAnimation.h"
#import "ShiningLabel.h"

@implementation AnimationStartVM

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 创建书动画
- (void)setupBookAnimation:(UIImageView *)coverView animationVC:(nonnull UIViewController *)animationVC{
    animationVC.bookCoverView = coverView;
    animationVC.transitionOperation = UINavigationControllerOperationPush;
    animationVC.targetClass = NSClassFromString(@"AnimationBookViewController");
    [animationVC appendTapActionWithTargetView:coverView];
    [animationVC appendEdgePanActionWithDirection:UIRectEdgeRight];
}

// 创建文字闪烁动画
- (ShiningLabel *)setupShiningLabelAnimation {
    NSString *title = @"当你远离了家";
    CGSize titleSize = [title sizeForFont:[UIFont systemFontOfSize:30] size:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:NSLineBreakByWordWrapping];
    CGFloat X = ScreenWidth/2 - titleSize.width /2;
    ShiningLabel *shiningLab = [[ShiningLabel alloc] init];
    shiningLab.frame = CGRectMake(X, 80, titleSize.width, titleSize.height);
    shiningLab.text = title;
    shiningLab.textColor = [UIColor grayColor];
    shiningLab.font = [UIFont systemFontOfSize:30];
    shiningLab.shimmerType = ST_ShimmerAll;
    shiningLab.durationTime = .8;
    shiningLab.shimmerColor = [UIColor redColor];
    return shiningLab;
}

- (TapLabel *)setupTestLab:(UIViewController *)vc {
    TapLabel *tempLab = [[TapLabel alloc] initWithFrame:CGRectMake(10, 150, 80, 40)];
    tempLab.backgroundColor = [UIColor yellowColor];
    tempLab.numberOfLines = 0;
    UIFont *attributeFont = [UIFont systemFontOfSize:18];
    NSMutableAttributedString *tempAttribute0 = [[NSMutableAttributedString alloc] initWithString:@"测试\n" attributes:@{NSFontAttributeName:attributeFont}];
    [tempLab addAttributedString:tempAttribute0 option:^(NSAttributedString * _Nonnull attributedString) {
        [vc pushVC:@"TestViewController"];
    }];
    return tempLab;
}

@end
