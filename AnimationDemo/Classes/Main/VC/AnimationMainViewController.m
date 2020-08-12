//
//  AnimationMainViewController.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/7/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationMainViewController.h"
#import "AnimationMainViewModel.h"

@interface AnimationMainViewController ()

/** mainVM */
@property (nonatomic,strong) AnimationMainViewModel *mainVM;

@end

@implementation AnimationMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.mainVM loadNav:self];
}

#pragma mark - lazy
- (AnimationMainViewModel *)mainVM {
    if (!_mainVM) {
        _mainVM = [[AnimationMainViewModel alloc] init];
    }
    return _mainVM;
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
