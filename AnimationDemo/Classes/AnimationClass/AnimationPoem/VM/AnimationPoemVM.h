//
//  AnimationPoemVM.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AnimationPoemVM : AnimationBaseViewModel

/// 创建诗篇
- (void)setupPoemView:(UIViewController *)poemView;

@end

NS_ASSUME_NONNULL_END
