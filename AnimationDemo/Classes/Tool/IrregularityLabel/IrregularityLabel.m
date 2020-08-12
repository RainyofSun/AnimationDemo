//
//  IrregularityLabel.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/4.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "IrregularityLabel.h"
#import "IrregularityTextContainer.h"

@interface IrregularityTextView : UITextView

@end

@implementation IrregularityTextView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch begin");
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end

@interface IrregularityLabel ()

/** textView */
@property (nonatomic,strong) IrregularityTextView *textView;
/** textContainer */
@property (nonatomic,strong) IrregularityTextContainer *textContainer;
/**layoutManager */
@property (nonatomic,strong) NSLayoutManager *layoutManager;
/** textStorage */
@property (nonatomic,strong) NSTextStorage *textStorage;

@end

@implementation IrregularityLabel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - override
- (instancetype)init {
    if (self = [super init]) {
        [self labelInit];
        [self propertyInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self labelInit];
        [self propertyInit];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textView.frame = self.bounds;
}

#pragma mark - private methods
- (void)labelInit {
    self.textContainer = [[IrregularityTextContainer alloc] init];
    self.layoutManager = [[NSLayoutManager alloc] init];
    self.textStorage   = [[NSTextStorage alloc] init];
    [self.layoutManager addTextContainer:self.textContainer];
    [self.textStorage addLayoutManager:self.layoutManager];
    self.textView = [[IrregularityTextView alloc] initWithFrame:CGRectZero textContainer:self.textContainer];
    [self addSubview:self.textView];
}

- (void)propertyInit {
    self.canScroll = NO;
    self.textView.editable = NO;
    self.textView.scrollEnabled = self.canScroll;
    self.textView.showsVerticalScrollIndicator = self.textView.showsHorizontalScrollIndicator = NO;
    self.textView.bounces = NO;
    self.textView.directionalLockEnabled = YES;
    self.textView.userInteractionEnabled = self.canScroll;
}

#pragma mark - set
- (void)setText:(NSString *)text {
    if (!text.length) {
        return;
    }
    _text = text;
    [self.textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:text];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.textView.textColor = textColor;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.textView.font = font;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    self.textView.attributedText = attributedText;
}

- (void)setCanScroll:(BOOL)canScroll {
    _canScroll = canScroll;
    self.textView.scrollEnabled = canScroll;
}

@end
