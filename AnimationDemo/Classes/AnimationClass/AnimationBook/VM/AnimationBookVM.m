//
//  AnimationBookVM.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/4.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationBookVM.h"
#import "UIViewController+BookCoverAnimation.h"
#import "DrawLightningAnimationLayer.h"
#import "StoryMakeImageEditorViewController.h"

@interface AnimationBookVM ()<EGLSGCDTimerDelegate>

/** lightningAnimationLayer */
@property (nonatomic,strong) DrawLightningAnimationLayer *lightningAnimationLayer;

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
    TapLabel *tempLab = [[TapLabel alloc] initWithFrame:CGRectMake(10, 100, ScreenWidth - 20, 200)];
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
    
    NSMutableAttributedString *tempAttribute4 = [[NSMutableAttributedString alloc] initWithString:@"文字动画\n" attributes:@{NSFontAttributeName:attributeFont}];
    [tempLab addAttributedString:tempAttribute4 option:^(NSAttributedString * _Nonnull attributedString) {
        if (touchCallBack) {
            touchCallBack(@"DrawWordsAnimationLayer");
        }
    }];
    
    NSMutableAttributedString *tempAttribute5 = [[NSMutableAttributedString alloc] initWithString:@"闪电动画\n" attributes:@{NSFontAttributeName:attributeFont}];
    [tempLab addAttributedString:tempAttribute5 option:^(NSAttributedString * _Nonnull attributedString) {
        if (touchCallBack) {
            touchCallBack(@"DrawLightningAnimationLayer");
        }
    }];
    
    NSMutableAttributedString *tempAttribute6 = [[NSMutableAttributedString alloc] initWithString:@"美图贴纸\n" attributes:@{NSFontAttributeName:attributeFont}];
    [tempLab addAttributedString:tempAttribute6 option:^(NSAttributedString * _Nonnull attributedString) {
        if (touchCallBack) {
            touchCallBack(@"StoryMakeImageEditorViewController");
        }
    }];
    
    NSMutableAttributedString *tempAttribute7 = [[NSMutableAttributedString alloc] initWithString:@"天气动画\n" attributes:@{NSFontAttributeName:attributeFont}];
    [tempLab addAttributedString:tempAttribute7 option:^(NSAttributedString * _Nonnull attributedString) {
        if (touchCallBack) {
            touchCallBack(@"WeatherAnimationViewController");
        }
    }];
    
    return tempLab;
}

// 创建不规则的label
- (IrregularityLabel *)setupIrregularityLabel {
    IrregularityLabel *tempLabel = [[IrregularityLabel alloc] initWithFrame:CGRectMake(30, 300, 300, 400)];
    tempLabel.text = @"a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a";
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

// 创建文字动画
- (DrawWordsAnimationLayer *)setupWordsAnimation:(NSString *)animationText {
    DrawWordsAnimationLayer *animationLayer = [DrawWordsAnimationLayer layer];
    [animationLayer createAnimationLayerWithWords:animationText animationRect:CGRectMake(0, 200, ScreenWidth, ScreenWidth) animationWordsFont:[UIFont systemFontOfSize:50] strokeColor:[UIColor purpleColor]];
    return animationLayer;
}

// 创建闪电动画
- (void)setupLightningAnimation:(UIView *)animationView {
    self.lightningAnimationLayer = [DrawLightningAnimationLayer layer];
    self.lightningAnimationLayer.frame = animationView.layer.frame;
    [animationView.layer addSublayer:self.lightningAnimationLayer];
    [EGLSGlobalGCDTimer GlobalTimerSetUp].timerDelegate = self;
    [[EGLSGlobalGCDTimer GlobalTimerSetUp] timerStart];
}

// 美图贴纸
- (void)stickerVC:(UIViewController *)vc {
    UIImage *image = [UIImage imageNamed:@"bgStory.jpg"];
    StoryMakeImageEditorViewController *storyMakerVc = [[StoryMakeImageEditorViewController alloc] initWithImage:image];
    [vc presentViewController:storyMakerVc animated:YES completion:nil];
}

#pragma mark - EGLSGCDTimerDelegate
- (void)countDownRefreshUI {
    if ([EGLSGlobalGCDTimer GlobalTimerSetUp].clockTime%3 == 0) {
        [self.lightningAnimationLayer setNeedsDisplay];
    }
}

@end
