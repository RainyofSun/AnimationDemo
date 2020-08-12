//
//  IrregularityLabel.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/4.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IrregularityLabel : UIView

// label 常用属性
/** text */
@property (nonatomic,copy) NSString *text;
/** textColor */
@property (nonatomic,strong) UIColor *textColor;
/** font */
@property (nonatomic,strong) UIFont *font;
/** attributedText */
@property (nonatomic,strong) NSAttributedString *attributedText;

// 定义属性
/** canScroll 默认不可以滚动 */
@property (nonatomic,assign) BOOL canScroll;

@end

NS_ASSUME_NONNULL_END
