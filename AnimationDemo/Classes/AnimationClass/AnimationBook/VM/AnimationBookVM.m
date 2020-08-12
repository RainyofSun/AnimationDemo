//
//  AnimationBookVM.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/4.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationBookVM.h"
#import "UIViewController+BookCoverAnimation.h"

@interface AnimationBookVM ()

@end

@implementation AnimationBookVM

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 创建书本动画
- (void)setupBookAnimation:(UIViewController *)bookVC {
    UIImageView *backImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_bookcover"]];
    backImgView.frame = CGRectMake(15, 30, 50, 50);
    [bookVC.view addSubview:backImgView];
    
    bookVC.transitionOperation = UINavigationControllerOperationPop;
    bookVC.targetClass = NSClassFromString(@"AnimationStartViewController");
    [bookVC appendTapActionWithTargetView:backImgView];
    [bookVC appendEdgePanActionWithDirection:UIRectEdgeLeft];
}

// 创建点击的label
- (TapLabel *)setupTapLabel:(void (^)(id _Nonnull))touchCallBack {
    TapLabel *tempLab = [[TapLabel alloc] initWithFrame:CGRectMake(10, 100, ScreenWidth - 20, 120)];
    tempLab.backgroundColor = [UIColor yellowColor];
    tempLab.numberOfLines = 0;
    UIFont *attributeFont = [UIFont systemFontOfSize:18];
    NSMutableAttributedString *tempAttribute0 = [[NSMutableAttributedString alloc] initWithString:@"雪花动画\n" attributes:@{NSFontAttributeName:attributeFont}];
    WEAK_DEFINE(self);
    [tempLab addAttributedString:tempAttribute0 option:^(NSAttributedString * _Nonnull attributedString) {
        if (touchCallBack) {
            touchCallBack([weak_self setupSnowAnimation]);
        }
    }];
    
    NSMutableAttributedString *tempAttribute1 = [[NSMutableAttributedString alloc] initWithString:@"樱花动画\n" attributes:@{NSFontAttributeName:attributeFont}];
    [tempLab addAttributedString:tempAttribute1 option:^(NSAttributedString * _Nonnull attributedString) {
        if (touchCallBack) {
            touchCallBack([weak_self setupCherryTreeAnimation]);
        }
    }];
    
    NSMutableAttributedString *tempAttribute2 = [[NSMutableAttributedString alloc] initWithString:@"画板\n" attributes:@{NSFontAttributeName:attributeFont}];
    [tempLab addAttributedString:tempAttribute2 option:^(NSAttributedString * _Nonnull attributedString) {
        if (touchCallBack) {
            touchCallBack(@"DrawingBoardViewController");
        }
    }];
    
    NSMutableAttributedString *tempAttribute3 = [[NSMutableAttributedString alloc] initWithString:@"涂鸦图片\n" attributes:@{NSFontAttributeName:attributeFont}];
    [tempLab addAttributedString:tempAttribute3 option:^(NSAttributedString * _Nonnull attributedString) {
        if (touchCallBack) {
            touchCallBack(@"GraffitiPictureViewController");
        }
    }];
    
    return tempLab;
}

// 创建不规则的label
- (IrregularityLabel *)setupIrregularityLabel {
    IrregularityLabel *tempLabel = [[IrregularityLabel alloc] initWithFrame:CGRectMake(30, 300, 300, 400)];
    tempLabel.text = @"a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a";
    tempLabel.textColor = [UIColor redColor];
    return tempLabel;
}

// 创建下雪动画
- (SnowAnimationView *)setupSnowAnimation {
    SnowAnimationView *snowAnimationView = [[SnowAnimationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [snowAnimationView startSnowAnimationWithAnimationType:SnowAnimationType_LayerAnimation];
    return snowAnimationView;
}

// 创建樱花动画
- (CherryTreeAnimationView *)setupCherryTreeAnimation {
    CherryTreeAnimationView *cherryTreeAnimationView = [[CherryTreeAnimationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [cherryTreeAnimationView animationStart];
    [cherryTreeAnimationView animationDuration:20];
    BLOCK_DEFINE(cherryTreeAnimationView);
    cherryTreeAnimationView.animationFinishBlock = ^{
        [BLOCK(cherryTreeAnimationView) removeFromSuperview];
        BLOCK(cherryTreeAnimationView) = nil;
        NSLog(@"动画结束了");
    };
    return cherryTreeAnimationView;
}

@end
