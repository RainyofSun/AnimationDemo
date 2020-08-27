//
//  ImageFilterViewController.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
// TODO: GPUImage 滤镜制作 https://github.com/sunjinshuai/GPUImageFilter

#import "ImageFilterViewController.h"
#import "ImageFilterVM.h"

@interface ImageFilterViewController ()<UINavigationControllerDelegate>

/** filterVM */
@property (nonatomic,strong) ImageFilterVM *filterVM;

@end

@implementation ImageFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazy
- (ImageFilterVM *)filterVM {
    if (!_filterVM) {
        _filterVM = [[ImageFilterVM alloc] init];
    }
    return _filterVM;
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
