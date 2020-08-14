//
//  DrawWordsAnimationLayer.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawWordsAnimationLayer : CALayer

- (void)createAnimationLayerWithWords:(NSString *)animationWords animationRect:(CGRect)rect animationWordsFont:(UIFont *)font strokeColor:(UIColor *)strokeColor;

@end

NS_ASSUME_NONNULL_END
