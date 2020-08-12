//
//  DrawingBoardVM.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DrawingBoardVM : AnimationBaseViewModel

/** NavBack */
@property (nonatomic,copy) void (^NavBack)(void);

// 创建画板
- (void)setupDrawingBoard:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
