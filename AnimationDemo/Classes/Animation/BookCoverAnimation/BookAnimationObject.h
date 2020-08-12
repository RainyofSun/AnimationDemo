//
//  BookAnimationObject.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/7/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookAnimationObject : NSObject

+ (id<UIViewControllerAnimatedTransitioning>)objectWithBookCoverView:(__kindof UIView *)bookCoverView animationControllerForOperation:(UINavigationControllerOperation)operation;

@end

NS_ASSUME_NONNULL_END
