//
//  DrawingBoardView.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawingBoardView : UIView

/** DrawBoardCallBack */
@property (nonatomic,copy) void (^DrawBoardCallBack)(NSInteger senderTag);

- (BOOL)saveTrajectory;
- (void)revocationOperation;
- (void)eraseScreenOperation;
- (void)stopEraseScreenOperation;
- (void)clearScreenOperation;
- (void)addChangeBrushWidthView;
- (void)addBrushColorView;

@end

NS_ASSUME_NONNULL_END
