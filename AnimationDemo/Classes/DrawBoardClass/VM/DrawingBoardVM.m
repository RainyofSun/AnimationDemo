//
//  DrawingBoardVM.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "DrawingBoardVM.h"
#import "DrawingBoardView.h"

@interface DrawingBoardVM ()

/** drawingBoardView */
@property (nonatomic,strong) DrawingBoardView *drawingBoardView;

@end

@implementation DrawingBoardVM

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 创建画板
- (void)setupDrawingBoard:(UIViewController *)vc {
    self.drawingBoardView = [[[NSBundle mainBundle] loadNibNamed:@"DrawingBoardView" owner:nil options:nil] firstObject];
    self.drawingBoardView.frame = vc.view.frame;
    [vc.view addSubview:self.drawingBoardView];
    [self blockCallBack];
}

#pragma mark - private methods
- (void)blockCallBack {
    WEAK_DEFINE(self);
    self.drawingBoardView.DrawBoardCallBack = ^(NSInteger senderTag) {
        switch (senderTag) {
            case 0:
                // 撤销
                [weak_self.drawingBoardView revocationOperation];
                break;
            case 1:
                // 画笔颜色
                [weak_self.drawingBoardView addBrushColorView];
                break;
            case 2:
                // 画笔宽度
                [weak_self.drawingBoardView addChangeBrushWidthView];
                break;
            case 3:
                // 清屏
                [weak_self.drawingBoardView clearScreenOperation];
                break;
            case 4:
                // 擦除
                [weak_self.drawingBoardView eraseScreenOperation];
                break;
            case 5:
                // 保存
                if ([weak_self.drawingBoardView saveTrajectory] && weak_self.NavBack) {
                    weak_self.NavBack();
                }
                break;
            case 6:
                // 继续作画
                [weak_self.drawingBoardView stopEraseScreenOperation];
                break;
            default:
                break;
        }
    };
}

@end
