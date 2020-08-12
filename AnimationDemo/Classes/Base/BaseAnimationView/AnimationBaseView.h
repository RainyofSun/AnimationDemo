//
//  AnimationBaseView.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/5.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AnimationFinishBlock)(void);

@interface AnimationBaseView : UIView

/** animationFinishBlock */
@property (nonatomic,copy) AnimationFinishBlock animationFinishBlock;

- (void)animationStart;
- (void)animationDuration:(CGFloat)duration;

@end

NS_ASSUME_NONNULL_END
