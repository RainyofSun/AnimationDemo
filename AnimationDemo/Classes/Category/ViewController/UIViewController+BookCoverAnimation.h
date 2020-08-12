//
//  UIViewController+BookCoverAnimation.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/7/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Transition.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BookCoverAnimation)

/** bookCoverView */
@property (nonatomic,strong) __kindof UIView *bookCoverView;

@end

NS_ASSUME_NONNULL_END
