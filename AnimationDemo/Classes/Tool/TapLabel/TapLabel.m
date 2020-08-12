//
//  TapLabel.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/3.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "TapLabel.h"

@interface TapLabel ()

@property (nonatomic, strong) NSMutableArray<NSAttributedString *> *subAttributedStrings;
@property (nonatomic, strong) NSMutableArray<NSValue *> *subAttributedStringRanges;
@property (nonatomic, strong) NSMutableArray<StringOption> *stringOptions;
@property (nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong) NSLayoutManager *layoutManager;
@property (nonatomic, strong) NSTextContainer *textContainer;

@end

@implementation TapLabel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)addAttributedString:(NSAttributedString *)attributedString option:(StringOption)option {
    [self.subAttributedStrings addObject:attributedString];
    NSRange range = NSMakeRange(self.textStorage.length, attributedString.length);
    [self.subAttributedStringRanges addObject:[NSValue valueWithRange:range]];
    [self.stringOptions addObject:option];
    [self.textStorage appendAttributedString:attributedString];
}

#pragma mark - set
- (void)setText:(NSString *)text {
    [super setText:text];
    [self setupTextSystem];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setupTextSystem];
}

#pragma mark - override
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        _subAttributedStrings = [NSMutableArray array];
        _subAttributedStringRanges = [NSMutableArray array];
        _stringOptions = [NSMutableArray array];
        [self setupTextSystem];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textContainer.size = self.bounds.size;
}

- (void)drawRect:(CGRect)rect {
    NSRange range = NSMakeRange(0, self.textStorage.length);
    [self.layoutManager drawBackgroundForGlyphRange:range atPoint:CGPointMake(0, 0)];
    [self.layoutManager drawGlyphsForGlyphRange:range atPoint:CGPointMake(0, 0)];
}

#pragma mark - event response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    // 根据点来获取位置 glyph 的index
    NSUInteger glyphIndex = [self.layoutManager glyphIndexForPoint:point inTextContainer:self.textContainer];
    // 获取 glyph 对应的rect
    CGRect glyphRect = [self.layoutManager boundingRectForGlyphRange:NSMakeRange(glyphIndex, 1) inTextContainer:self.textContainer];
    // 最终判断自行的显示范围是否包括点击的 location
    if (CGRectContainsPoint(glyphRect, point)) {
        NSUInteger characterIndex = [self.layoutManager characterIndexForGlyphAtIndex:glyphIndex];
        
        [self.subAttributedStringRanges enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = obj.rangeValue;
            if (NSLocationInRange(characterIndex, range)) {
                StringOption option = self.stringOptions[idx];
                option(self.subAttributedStrings[idx]);
            }
        }];
    }
}

#pragma mark - private methods
- (void)setupTextSystem {
    _textStorage = [[NSTextStorage alloc] init];
    _layoutManager = [[NSLayoutManager alloc] init];
    _textContainer = [[NSTextContainer alloc] init];
    
    [_textStorage addLayoutManager:_layoutManager];
    [_layoutManager addTextContainer:_textContainer];
}

@end
