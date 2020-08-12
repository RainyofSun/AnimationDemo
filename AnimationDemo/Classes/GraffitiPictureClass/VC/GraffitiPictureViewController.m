//
//  GraffitiPictureViewController.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "GraffitiPictureViewController.h"
#import "GraffitiPictureVM.h"

@interface GraffitiPictureViewController ()

/** graffitiPicVM */
@property (nonatomic,strong) GraffitiPictureVM *graffitiPicVM;

@end

@implementation GraffitiPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self blockCallBack];
    [self.graffitiPicVM setupGraffitiBoard:self];
}

- (void)blockCallBack {
    WEAK_DEFINE(self);
    self.graffitiPicVM.NavBack = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
}

#pragma mark - lazy
- (GraffitiPictureVM *)graffitiPicVM {
    if (!_graffitiPicVM) {
        _graffitiPicVM = [[GraffitiPictureVM alloc] init];
    }
    return _graffitiPicVM;
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
