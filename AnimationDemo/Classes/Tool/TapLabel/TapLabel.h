//
//  TapLabel.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/3.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^StringOption)(NSAttributedString *attributedString);

@interface TapLabel : UILabel

/**
 * 添加一个NSAttributeString,并关联事件
 * @param attributedString 属性字符串
 * @param option 事件
 */
- (void)addAttributedString:(NSAttributedString *)attributedString option:(StringOption)option;

@end

NS_ASSUME_NONNULL_END
