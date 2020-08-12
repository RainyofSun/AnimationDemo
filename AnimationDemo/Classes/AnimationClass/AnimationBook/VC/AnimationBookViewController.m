//
//  AnimationBookViewController.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/7/31.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationBookViewController.h"
#import "AnimationBookVM.h"

@interface AnimationBookViewController ()<UINavigationControllerDelegate>

/** bookVM */
@property (nonatomic,strong) AnimationBookVM *bookVM;

@end

@implementation AnimationBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addUI];
}

- (void)addUI {
    WEAK_DEFINE(self);
    [self.bookVM setupBookAnimation:self];
    [self.view addSubview:[self.bookVM setupTapLabel:^(id  _Nonnull animationThings) {
        if ([animationThings isKindOfClass:[UIView class]]) {
            [weak_self.view addSubview:(UIView *)animationThings];
        } else if ([animationThings isKindOfClass:[NSString class]]) {
            [weak_self pushVC:(NSString *)animationThings];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
