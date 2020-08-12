//
//  BrushColorView.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ColorSelectorDelegate <NSObject>

- (void)selectColor:(UIColor *)color;

@end

@interface ColorExtractorView : UIView

/** colorDelegate */
@property (nonatomic,weak) id<ColorSelectorDelegate> colorDelegate;

+ (instancetype)instanceWithView:(UIView *)view topDistanceWithSuperView:(CGFloat)distance;

@end

NS_ASSUME_NONNULL_END
