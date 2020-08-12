//
//  ShiningLabel.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/3.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "ShiningLabel.h"

@interface ShiningLabel ()

/** contentLab */
@property (nonatomic,strong) UILabel *contentLab;
/** maskLab */
@property (nonatomic,strong) UILabel *maskLab;
/** maskLayer */
@property (nonatomic,strong) CAGradientLayer *maskLayer;
/** isPlaying 是否在播放动画 */
@property (nonatomic,assign,readwrite) BOOL isPlaying;
/** charSize */
@property (nonatomic,assign) CGSize charSize;
/** startT */
@property (nonatomic,assign) CATransform3D startT;
/** endT */
@property (nonatomic,assign) CATransform3D endT;
/** translate */
@property (nonatomic,strong) CABasicAnimation *translate;
/** alphaAni */
@property (nonatomic,strong) CABasicAnimation *alphaAni;

@end

@implementation ShiningLabel

#pragma mark - lifeStyle
- (instancetype)init {
    if (self = [super init]) {
        self.frame =  CGRectMake(0, 0, 60, 30);
        [self shiningLabelInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self shiningLabelInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self shiningLabelInit];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 刷新布局
    self.contentLab.frame = self.bounds;
    self.maskLab.frame = self.bounds;
    self.maskLayer.frame = CGRectMake(0, 0, self.charSize.width, self.charSize.height);
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)startShimmer {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.isPlaying) {
            return ;
        }
        self.isPlaying = YES;
        [self copyLabel:self.maskLab from:self.contentLab];
        self.maskLab.hidden = NO;
        
        [self.maskLayer removeFromSuperlayer];
        [self freshMaskLayer];
        [self.maskLab.layer addSublayer:self.maskLayer];
        self.maskLab.layer.mask = self.maskLayer;
        
        switch (self.shimmerType) {
            case ST_LeftToRight:
                self.maskLayer.transform = self.startT;
                self.translate.fromValue = [NSValue valueWithCATransform3D:self.startT];
                self.translate.toValue = [NSValue valueWithCATransform3D:self.endT];
                [self.maskLayer removeAllAnimations];
                [self.maskLayer addAnimation:self.translate forKey:@"start"];
                break;
            case ST_RightToLeft:
                self.maskLayer.transform = self.endT;
                self.translate.fromValue = [NSValue valueWithCATransform3D:self.endT];
                self.translate.toValue = [NSValue valueWithCATransform3D:self.startT];
                [self.maskLayer removeAllAnimations];
                [self.maskLayer addAnimation:self.translate forKey:@"start"];
                break;
            case ST_AutoReverse:
                self.maskLayer.transform = self.startT;
                self.translate.fromValue = [NSValue valueWithCATransform3D:self.startT];
                self.translate.toValue = [NSValue valueWithCATransform3D:self.endT];
                [self.maskLayer removeAllAnimations];
                [self.maskLayer addAnimation:self.translate forKey:@"start"];
                break;
            case ST_ShimmerAll:
                self.maskLayer.transform = CATransform3DIdentity;
                [self.maskLayer removeAllAnimations];
                [self.maskLayer addAnimation:self.alphaAni forKey:@"start"];
                break;
            default:
                break;
        }
    });
}

- (void)restartAnimation {
    self.isPlaying = NO;
    [self startShimmer];
}

- (void)endShimmer {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.isPlaying) {
            return ;
        }
        self.isPlaying = NO;
        [self.maskLayer removeAllAnimations];
        [self.maskLayer removeFromSuperlayer];
        self.maskLab.hidden = YES;
    });
}

#pragma mark - private methods
- (void)shiningLabelInit {
    [self addSubview:self.contentLab];
    [self addSubview:self.maskLab];
    self.layer.masksToBounds = YES;
    self.isPlaying = NO;
    self.startT = CATransform3DIdentity;
    self.endT = CATransform3DIdentity;
    self.charSize = CGSizeMake(0, 0);
    self.shimmerType = ST_LeftToRight;
    self.repeat = YES;
    self.shimmerWidth = 20;
    self.shimmerRadius = 20;
    self.shimmerColor = [UIColor whiteColor];
    self.durationTime = 2;
    self.textAlignment = NSTextAlignmentCenter;
}

// 刷新maskLayer的属性值，transform 值
- (void)freshMaskLayer {
    if (self.shimmerType == ST_ShimmerAll) {
        _maskLayer.backgroundColor = self.shimmerColor.CGColor;
        _maskLayer.colors = nil;
        _maskLayer.locations = nil;
        return;
    }
    
    _maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    _maskLayer.startPoint = CGPointMake(0, 0.5);
    _maskLayer.endPoint = CGPointMake(1, 0.5);
    _maskLayer.colors = @[(id)[UIColor clearColor].CGColor,
                          (id)[UIColor clearColor].CGColor,
                          (id)[UIColor whiteColor].CGColor,
                          (id)[UIColor whiteColor].CGColor,
                          (id)[UIColor clearColor].CGColor,
                          (id)[UIColor clearColor].CGColor];
    CGFloat w = 1.0;
    CGFloat sw = 1.0;
    if (self.charSize.width >= 1) {
        w = self.shimmerWidth/self.charSize.width * 0.5;
        sw = self.shimmerRadius/self.charSize.width;
    }
    _maskLayer.locations = @[@(0.0),@(0.5 - w - sw),@(0.5 - w),@(0.5 + w),@(0.5 + w + sw),@(1)];
    CGFloat startX = self.charSize.width * (.5 - w - sw);
    CGFloat endX = self.charSize.width * (.5 + w + sw);
    self.startT = CATransform3DMakeTranslation(-endX, 0, 1);
    self.endT = CATransform3DMakeTranslation(self.charSize.width - startX, 0, 1);
}

- (void)update {
    if (self.isPlaying) {
        [self endShimmer];
        [self startShimmer];
    }
}

- (void)copyLabel:(UILabel *)dLab from:(UILabel *)sLab {
    if (nil != self.attributedText) {
        dLab.attributedText = sLab.attributedText;
    }
    dLab.text = sLab.text;
    dLab.font = sLab.font;
    dLab.numberOfLines = sLab.numberOfLines;
    dLab.textAlignment = sLab.textAlignment;
}

#pragma mark - set/get
- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] init];
        _contentLab.font = [UIFont systemFontOfSize:17];
        _contentLab.textColor = [UIColor darkGrayColor];
    }
    return _contentLab;
}

- (UILabel *)maskLab {
    if (!_maskLab) {
        _maskLab = [[UILabel alloc] init];
        _maskLab.font = [UIFont systemFontOfSize:17];
        _maskLab.textColor = [UIColor darkGrayColor];
        _maskLab.hidden = YES;
    }
    return _maskLab;
}

- (CAGradientLayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [[CAGradientLayer alloc] init];
        _maskLayer.backgroundColor = [UIColor clearColor].CGColor;
        [self freshMaskLayer];
    }
    return _maskLayer;
}

- (CABasicAnimation *)translate {
    if (!_translate) {
        _translate = [CABasicAnimation animationWithKeyPath:@"transform"];
    }
    _translate.duration = self.durationTime;
    _translate.repeatCount = self.repeat ? MAXFLOAT : 0;
    _translate.autoreverses = (self.shimmerType == ST_AutoReverse);
    return _translate;
}

- (CABasicAnimation *)alphaAni {
    if (!_alphaAni) {
        _alphaAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _alphaAni.repeatCount = MAXFLOAT;
        _alphaAni.autoreverses = YES;
        _alphaAni.fromValue = @(0.0);
        _alphaAni.toValue = @(1.0);
    }
    _alphaAni.duration = self.durationTime;
    return _alphaAni;
}

- (void)setText:(NSString *)text {
    if ([_text isEqualToString:text]) {
        return;
    }
    _text = text;
    self.contentLab.text = text;
    self.charSize = [self.contentLab.text boundingRectWithSize:self.contentLab.size options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.contentLab.font} context:nil].size;
    [self update];
}

- (void)setFont:(UIFont *)font {
    if ([_font isEqual:font]) {
        return;
    }
    _font = font;
    self.contentLab.font =  font;
    self.charSize = [self.contentLab.text boundingRectWithSize:self.contentLab.size options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.contentLab.font} context:nil].size;
    [self update];
}

- (void)setTextColor:(UIColor *)textColor {
    if ([_textColor isEqual:textColor]) {
        return;
    }
    _textColor = textColor;
    self.charSize = [self.contentLab.text boundingRectWithSize:self.contentLab.size options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.contentLab.font} context:nil].size;
    [self update];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if ([_attributedText isEqualToAttributedString:attributedText]) {
        return;
    }
    _attributedText = attributedText;
    self.contentLab.attributedText = attributedText;
    [self update];
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    if (_numberOfLines == numberOfLines) {
        return;
    }
    
    _numberOfLines = numberOfLines;
    self.contentLab.numberOfLines = numberOfLines;
    [self update];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    if (_textAlignment == textAlignment) {
        return;
    }
    _textAlignment = textAlignment;
    self.contentLab.textAlignment = textAlignment;
    [self update];
}

- (void)setShimmerType:(ShimmerType)shimmerType {
    if (_shimmerType == shimmerType) {
        return;
    }
    _shimmerType = shimmerType;
    [self update];
}

- (void)setRepeat:(BOOL)repeat {
    if (_repeat == repeat) {
        return;
    }
    _repeat = repeat;
    [self update];
}

- (void)setShimmerWidth:(CGFloat)shimmerWidth {
    if (_shimmerWidth == shimmerWidth) {
        return;
    }
    _shimmerWidth = shimmerWidth;
    [self update];
}

- (void)setShimmerRadius:(CGFloat)shimmerRadius {
    if (_shimmerRadius == shimmerRadius) {
        return;
    }
    _shimmerRadius = shimmerRadius;
    [self update];
}

- (void)setShimmerColor:(UIColor *)shimmerColor {
    if ([_shimmerColor isEqual:shimmerColor]) {
        return;
    }
    _shimmerColor = shimmerColor;
    self.maskLab.textColor = shimmerColor;
    [self update];
}

- (void)setDurationTime:(NSTimeInterval)durationTime {
    if (_durationTime == durationTime) {
        return;
    }
    _durationTime = durationTime;
    [self update];
}

@end
