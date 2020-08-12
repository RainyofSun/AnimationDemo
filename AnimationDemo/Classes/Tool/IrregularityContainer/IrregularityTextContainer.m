//
//  IrregularityTextContainer.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/3.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "IrregularityTextContainer.h"

@implementation IrregularityTextContainer

#pragma mark - override
- (CGRect)lineFragmentRectForProposedRect:(CGRect)proposedRect atIndex:(NSUInteger)characterIndex writingDirection:(NSWritingDirection)baseWritingDirection remainingRect:(CGRect *)remainingRect {
    // 原始的范围哦
    CGRect rect = [super lineFragmentRectForProposedRect:proposedRect atIndex:characterIndex writingDirection:baseWritingDirection remainingRect:remainingRect];
    // 当前现实区域
    CGSize size = [self size];
    // 当前区域的内切圆半径
    CGFloat radius = fmin(size.width, size.height) * .5;
    // 得到不同状态下的当前行的高度
    CGFloat width = 0;
    if (proposedRect.origin.y == 0) {
        // 初始化的宽度
        width = 40.0;
    } else if (proposedRect.origin.y <= 2 * radius) {
        // 圆范围的行宽度
        width = 2.0 * sqrt(powf(radius, 2.0) - powf(fabs(proposedRect.origin.y - radius), 2.0));
    } else {
        // 范围外的宽度
        width = 100.0;
    }
    // 最终该行的宽度
    CGRect circleRect = CGRectMake(radius - width/2, proposedRect.origin.y, width, proposedRect.size.height);
    // 返回一个和原始范围的交集，防止溢出
    return CGRectIntersection(rect, circleRect);
}

@end
