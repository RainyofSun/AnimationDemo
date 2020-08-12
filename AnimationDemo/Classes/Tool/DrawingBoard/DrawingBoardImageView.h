//
//  DrawingBoardImageView.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawingBoardImageView : UIImageView

/** 清屏 */
- (void)clearScreen;
/** 撤消操作 */
- (void)revokeScreen;
/** 擦除 */
- (void)eraseScreen;
/** 停止擦除 */
- (void)stopEraseScreen;
/** 设置画笔颜色 */
- (void)setStrokeColor:(UIColor *)lineColor;
/** 设置画笔大小 */
- (void)setStrokeWidth:(CGFloat)lineWidth;
/** 获取涂鸦图片 */
- (UIImage *)getImage;
/** 保存图片到相册 */
- (BOOL)saveGraffitiPictureToPhotoAlbum;

@end

NS_ASSUME_NONNULL_END
