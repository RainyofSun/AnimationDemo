//
//  DrawingBoardViewController.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "DrawingBoardViewController.h"
#import "DrawingBoardVM.h"

@interface DrawingBoardViewController ()

/** drawBoardVM */
@property (nonatomic,strong) DrawingBoardVM *drawBoardVM;

@end

@implementation DrawingBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self blockCallBack];
    [self.drawBoardVM setupDrawingBoard:self];
}

- (void)blockCallBack {
    WEAK_DEFINE(self);
    self.drawBoardVM.NavBack = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
}

#pragma mark - lazy
- (DrawingBoardVM *)drawBoardVM {
    if (!_drawBoardVM) {
        _drawBoardVM = [[DrawingBoardVM alloc] init];
    }
    return _drawBoardVM;
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
