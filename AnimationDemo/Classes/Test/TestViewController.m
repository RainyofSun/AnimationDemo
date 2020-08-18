//
//  TestViewController.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "TestViewController.h"
#import "StoryMakeFilterFooterView.h"
#define SCREENAPPLYSPACE(x) ScreenWidth / 375.0 * (x)
#define SCREENAPPLYHEIGHT(x) ScreenHeight / 667.0 * (x)

@interface TestViewController ()<StoryMakeFilterFooterViewDelegate>

@property (nonatomic, strong) StoryMakeFilterFooterView *filterFooterView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showwFilterView];
    [self.view addSubview:self.filterFooterView];
}

- (void)showwFilterView {
    [self.filterFooterView updateFilterViewWithImage:[UIImage imageNamed:@"bgStory"]];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.filterFooterView.center = self.view.center;
                     }];
}

- (void)storyMakeFilterFooterViewCloseBtnClicked
{
    [UIView animateWithDuration:0.3 animations:^{
        self.filterFooterView.center = CGPointMake(self.view.center.x, self.view.center.y + SCREENAPPLYHEIGHT(667));
    } completion:^(BOOL finished) {
        [self.filterFooterView removeFromSuperview];
        self.filterFooterView = nil;
    }];
}

- (void)storyMakeFilterFooterViewConfirmBtnClicked:(UIImage *)drawImage
{
    self.filterFooterView.center = CGPointMake(self.view.center.x, self.view.center.y + SCREENAPPLYHEIGHT(667));
}

- (StoryMakeFilterFooterView *)filterFooterView
{
    if (!_filterFooterView) {
        _filterFooterView = [[StoryMakeFilterFooterView alloc] init];
        _filterFooterView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame), ScreenWidth, ScreenHeight);
        _filterFooterView.delegate = self;
    }
    return _filterFooterView;
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
