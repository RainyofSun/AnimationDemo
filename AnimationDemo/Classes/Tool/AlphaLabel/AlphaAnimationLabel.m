//
//  AlphaAnimationLabel.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/20.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AlphaAnimationLabel.h"
#import <CoreText/CoreText.h>

@interface AlphaAnimationLabel ()

/** animationView */
@property (nonatomic,strong) UIView *animationView;
/** textLayer */
@property (nonatomic,strong) CATextLayer *textLayer;

/** labels */
@property (nonatomic,strong) NSMutableArray *labels;
/** numArr */
@property (nonatomic,strong) NSMutableArray *numArr;
/** dataArr */
@property (nonatomic,strong) NSMutableArray *dataArr;

/** textIndex */
@property (nonatomic,assign) NSInteger textIndex;

@end

@implementation AlphaAnimationLabel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (instancetype)initWithAlphaAnimationLabelFrame:(CGRect)frame {
    if (self = [super init]) {
        [self initAlphaAnimationLabel:frame];
    }
    return self;
}

- (UIView *)alphaAnimationLabel {
    [self drawAlphaAnimation];
    return self.animationView;
}

- (void)startAnimation {
    for (NSInteger i = 0; i < self.text.length; i ++) {
        [self.numArr addObject:[NSNumber numberWithInteger:i]];
        [self performSelector:@selector(changeAlpah) withObject:nil afterDelay:(0.3 * i)];
    }
}

#pragma mark - private methods
- (void)initAlphaAnimationLabel:(CGRect)rect {
    self.animationView.frame = rect;
    self.textLayer.frame = self.animationView.bounds;
    self.textLayer.contentsScale = [UIScreen mainScreen].scale;
    self.textLayer.alignmentMode = kCAAlignmentJustified;
    self.textLayer.wrapped = YES;
    
    [self.animationView.layer addSublayer:self.textLayer];
    self.font = [UIFont fontWithName:@"EuphemiaUCAS-Bold" size:15];
    self.textIndex = 0;
}

- (void)drawAlphaAnimation {
    [self.dataArr removeAllObjects];
    [self.numArr removeAllObjects];
    [self.dataArr removeAllObjects];
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self.text];
    CFStringRef fontName = (__bridge CFStringRef)self.font.fontName;
    CGFloat fontSize = self.font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    NSDictionary *attribs = @{(__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor clearColor].CGColor,
                              (__bridge id)kCTFontAttributeName:(__bridge id)fontRef
    };
    [attribute setAttributes:attribs range:NSMakeRange(0, self.text.length)];
    
    [self.dataArr addObjectsFromArray:@[(__bridge id _Nonnull)fontRef,attribs,attribute]];
    CFRelease(fontRef);
}

- (void)changeAlpah {
    self.textIndex ++;
    CTFontRef fontRef = (__bridge CTFontRef)self.dataArr.firstObject;
    NSMutableAttributedString *attributeStr = self.dataArr[2];
    NSNumber *num = self.numArr.firstObject;
    NSDictionary *attributeDict = self.dataArr[1];
    attributeDict = @{(__bridge id)kCTForegroundColorAttributeName:(__bridge id)self.textColor.CGColor,
                    (__bridge id)kCTFontAttributeName:(__bridge id)fontRef
    };
    [attributeStr setAttributes:attributeDict range:NSMakeRange(num.integerValue, 1)];
    if (self.numArr.count > 1) {
        [self.numArr removeObjectAtIndex:0];
    }
    self.textLayer.string = attributeStr;
    if (self.textIndex == (self.text.length - 1) && self.animationFinishBlock) {
        self.textIndex = 0;
        self.animationFinishBlock(YES);
    }
}

// 获取系统字体库
- (void)systemWordFont {
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
}

#pragma mark - lazy
- (UIView *)animationView {
    if (!_animationView) {
        _animationView = [[UIView alloc] init];
    }
    return _animationView;
}

- (CATextLayer *)textLayer {
    if (!_textLayer) {
        _textLayer = [CATextLayer layer];
    }
    return _textLayer;
}

- (NSMutableArray *)labels {
    if (!_labels) {
        _labels = [NSMutableArray array];
    }
    return _labels;
}

- (NSMutableArray *)numArr {
    if (!_numArr) {
        _numArr = [NSMutableArray array];
    }
    return _numArr;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
