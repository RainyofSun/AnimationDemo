//
//  WeatherAnimationVM.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "WeatherAnimationVM.h"
#import "WeatherAnimationFactory.h"

@interface WeatherAnimationVM ()

/** animationFactory */
@property (nonatomic,strong) WeatherAnimationFactory *animationFactory;

@end

@implementation WeatherAnimationVM

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)setupWeatherAnimation:(UIView *)animationView {
    self.animationFactory = [[WeatherAnimationFactory alloc]  initWithWeatherAnimationView:animationView];
    [self.animationFactory addWeatherAnimationFactoryWithType:WeatherAnimationType_Sun];
}

- (void)weatherAnimationStop {
    [self.animationFactory removeAllAnimation];
}

- (void)addBottomMenuView:(UIView *)view {
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 80, ScreenWidth, 80)];
    menuView.backgroundColor = [UIColor clearColor];
    NSArray *menuArray = @[@"sun",@"cloud",@"Rain",@"thunder",@"snow"];
    for (NSInteger i = 0; i < menuArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:menuArray[i] forState:UIControlStateNormal];
        btn.layer.borderWidth = 1.f;
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.tag = i;
        [btn addTarget:self action:@selector(touchMenu:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(80 * i + 10, 10, 70, 40);
        [menuView addSubview:btn];
    }
    [view addSubview:menuView];
}

#pragma mark - Target
- (void)touchMenu:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [self.animationFactory addWeatherAnimationFactoryWithType:WeatherAnimationType_Sun];
            break;
        case 1:
            [self.animationFactory addWeatherAnimationFactoryWithType:WeatherAnimationType_Cloud];
            break;
        case 2:
            [self.animationFactory addWeatherAnimationFactoryWithType:WeatherAnimationType_Rain];
            break;
        case 3:
            [self.animationFactory addWeatherAnimationFactoryWithType:WeatherAnimationType_RainLighting];
            break;
        case 4:
            [self.animationFactory addWeatherAnimationFactoryWithType:WeatherAnimationType_Snow];
            break;
        default:
            break;
    }
}

@end
