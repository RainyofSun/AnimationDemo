//
//  GraffitiPictureView.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GraffitiPictureView : UIView

/** GraffitiBoardCallBack */
@property (nonatomic,copy) void (^GraffitiBoardCallBack)(NSInteger senderTag);

- (BOOL)saveTrajectory;
- (void)revocationOperation;
- (void)eraseScreenOperation;
- (void)stopEraseScreenOperation;
- (void)clearScreenOperation;
- (void)addChangeBrushWidthView;
- (void)addBrushColorView;

- (void)updateGraffitiPicture:(UIImage *)graffitiPic;

@end

NS_ASSUME_NONNULL_END
