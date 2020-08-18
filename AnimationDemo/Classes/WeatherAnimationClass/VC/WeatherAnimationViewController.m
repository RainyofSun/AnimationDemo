//
//  WeatherAnimationViewController.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "WeatherAnimationViewController.h"
#import "WeatherAnimationVM.h"

@interface WeatherAnimationViewController ()

/** animationVM */
@property (nonatomic,strong) WeatherAnimationVM *animationVM;

@end

@implementation WeatherAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.animationVM setupWeatherAnimation:self.view];
        [self.animationVM addBottomMenuView:self.view];
    });
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.animationVM weatherAnimationStop];
}

#pragma mark - lazy
- (WeatherAnimationVM *)animationVM {
    if (!_animationVM) {
        _animationVM = [[WeatherAnimationVM alloc] init];
    }
    return _animationVM;
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
