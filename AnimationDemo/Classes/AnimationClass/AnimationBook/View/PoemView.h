//
//  PoemView.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/21.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PoemView : UIView

/** poemSize */
@property (nonatomic,readonly) CGSize poemSize;

- (void)startAnimation;

@end

NS_ASSUME_NONNULL_END
