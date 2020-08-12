//
//  SnowAnimationView.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/4.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SnowAnimationType_LayerAnimation,
    SnowAnimationType_EmitterAnimation,
} SnowAnimationType;

@interface SnowAnimationView : UIView

- (void)startSnowAnimationWithAnimationType:(SnowAnimationType)animatonType;

@end

NS_ASSUME_NONNULL_END
