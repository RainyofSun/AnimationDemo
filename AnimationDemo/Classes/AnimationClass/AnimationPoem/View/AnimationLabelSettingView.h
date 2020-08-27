//
//  AnimationLabelSettingView.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimationLabelSettingView : UIView

/** settingViewH */
@property (nonatomic,readonly) CGFloat settingViewH;

- (void)setAnimationStyle:(NSInteger)animationStyle withAnimationType:(NSInteger)animationType;

@end

NS_ASSUME_NONNULL_END
