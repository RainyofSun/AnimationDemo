//
//  AnimationBookViewController.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/7/31.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationBookViewController.h"
#import "BubbleTransitionAnimation.h"
#import "AnimationBookVM.h"

@interface AnimationBookViewController ()<UINavigationControllerDelegate,CAAnimationDelegate,UIViewControllerTransitioningDelegate>

/** bookVM */
@property (nonatomic,strong) AnimationBookVM *bookVM;
/** transition */
@property (nonatomic,strong) BubbleTransitionAnimation *transition;

@end

@implementation AnimationBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupBackgroud];
//    [self addUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.bookVM setupCherryTreeAnimation:self.view]; // 回退动画有影响
    self.view.layer.contents = nil;
    [self.bookVM setupPoemView:self.view];
    [self.bookVM setupBookAnimation:self];
    self.navigationController.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.bookVM removeAnimationView];
}

#pragma mark - 消息透传
- (void)showPoem {
    UIViewController *vc = [[NSClassFromString(@"PoemAnimationViewController") alloc] init];
    vc.transitioningDelegate = self;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.view.frame = self.view.frame;
    [self presentVC:vc];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.transition.transitionModel = BubbleTransitionModel_Present;
    self.transition.startPoint = CGPointMake(self.view.center.x, ScreenHeight - 100);
    return self.transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.transition.transitionModel = BubbleTransitionModel_Dismiss;
    self.transition.startPoint = CGPointMake(self.view.center.x, ScreenHeight - 100);
    return self.transition;
}

- (void)setupBackgroud {
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"cherrytrees"].CGImage;
    self.view.layer.contentsGravity = kCAGravityResizeAspectFill;
}

- (void)addUI {
    WEAK_DEFINE(self);
    [self.bookVM setupBookAnimation:self];
    [self.view addSubview:[self.bookVM setupTapLabel:^(id  _Nonnull animationThings) {
        if ([animationThings isKindOfClass:[UIView class]]) {
            [weak_self.view addSubview:(UIView *)animationThings];
        } else if ([animationThings isKindOfClass:[NSString class]]) {
            if ([animationThings isEqual:@"DrawWordsAnimationLayer"]) {
                [weak_self.view.layer addSublayer:[weak_self.bookVM setupWordsAnimation:@"Love You"]];
            } else if ([animationThings isEqual:@"DrawLightningAnimationLayer"]) {
                [weak_self.bookVM setupLightningAnimation:weak_self.view];
            } else if ([animationThings isEqual:@"StoryMakeImageEditorViewController"]) {
                [weak_self.bookVM stickerVC:weak_self];
            } else {
                [weak_self pushVC:(NSString *)animationThings];
            }
        }
    }]];
    [self.view addSubview:[self.bookVM setupIrregularityLabel]];
    self.navigationController.delegate = self;
}

#pragma mark - lazy
- (AnimationBookVM *)bookVM {
    if (!_bookVM) {
        _bookVM = [[AnimationBookVM alloc] init];
    }
    return _bookVM;
}

- (BubbleTransitionAnimation *)transition {
    if (!_transition) {
        _transition = [[BubbleTransitionAnimation alloc] init];
    }
    return _transition;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
