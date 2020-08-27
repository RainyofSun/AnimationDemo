//
//  AnimationPoemView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationPoemView.h"
#import "AnimationLabelSettingView.h"

@interface AnimationPoemView ()

/** animationLabel */
@property (nonatomic,strong) ZCAnimatedLabel *animationLabel;
/** animationSettingBtn */
@property (nonatomic,strong) UIButton *animationSettingBtn;
/** settingView */
@property (nonatomic,strong) AnimationLabelSettingView *settingView;

/** animationType */
@property (nonatomic,assign) NSInteger animationType;
/** animationStyle */
@property (nonatomic,assign) NSInteger animationStyle;

@end

@implementation AnimationPoemView

- (instancetype)init {
    if (self = [super init]) {
        [self initAnimationLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.animationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(-30);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.bounds) * 0.9, CGRectGetHeight(self.bounds) * 0.8));
    }];
    
    [self.animationSettingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(-40);
    }];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - private methods
- (void)initAnimationLabel {
    [self addSubview:self.animationLabel];
    [self addSubview:self.animationSettingBtn];
    
    [self.animationSettingBtn setTitle:@"文字动画属性设置" forState:UIControlStateNormal];
    [self.animationSettingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.animationSettingBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.animationSettingBtn.layer.borderWidth = 1.f;
    self.animationSettingBtn.layer.cornerRadius = 5.f;
    self.animationSettingBtn.clipsToBounds = YES;
    [self.animationSettingBtn setTarget:self action:@selector(animationSetting:) forControlEvents:UIControlEventTouchUpInside];
    
    self.animationLabel.backgroundColor = [UIColor clearColor];
    [self animationLabelAppear:YES];
}

- (void)animationLabelAppear:(BOOL)appear {
    self.animationLabel.animationDuration = 0.5;
    self.animationLabel.animationDelay = 0.07;
    self.animationLabel.text = @"春江潮水连海平，海上明月共潮生。\n滟滟随波千万里，何处春江无月明！\n江流宛转绕芳甸，月照花林皆似霰；\n空里流霜不觉飞，汀上白沙看不见。\n江天一色无纤尘，皎皎空中孤月轮。\n江畔何人初见月？江月何年初照人？\n人生代代无穷已，江月年年望相似。\n不知江月待何人，但见长江送流水。\n白云一片去悠悠，青枫浦上不胜愁。\n谁家今夜扁舟子？何处相思明月楼？\n可怜楼上月徘徊，应照离人妆镜台。\n玉户帘中卷不去，捣衣砧上拂还来。\n此时相望不相闻，愿逐月华流照君。\n鸿雁长飞光不度，鱼龙潜跃水成文。\n昨夜闲潭梦落花，可怜春半不还家。\n江水流春去欲尽，江潭落月复西斜。\n斜月沉沉藏海雾，碣石潇湘无限路。\n不知乘月几人归，落月摇情满江树。";
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = 5;
    style.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *mutableString = [[[NSAttributedString alloc] initWithString:self.animationLabel.text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20], NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : [UIColor whiteColor]}] mutableCopy];
    self.animationLabel.attributedString = mutableString;
    if (appear) {
        [self.animationLabel startAppearAnimation];
    } else {
        [self.animationLabel startDisappearAnimation];
    }
}

#pragma mark - Target
- (void)animationSetting:(UIButton *)sender {
    if (!_settingView) {
        [self addSubview:self.settingView];
        self.settingView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, self.settingView.settingViewH);
    }
    [self.settingView show:AnimationDirection_Bottom];
}

#pragma mark - 消息透传
- (void)animationLabelStyle:(NSNumber *)animationStyle duration:(NSNumber *)duration delayTime:(NSNumber *)delayTime animationType:(NSNumber *)animationType {
    [self.animationLabel stopAnimation];
    if (animationStyle.integerValue != 0) {
        [self.animationLabel.layoutTool cleanLayout];
        self.animationLabel.layoutTool.groupType = self.animationStyle = animationStyle.integerValue - 1;
    }
    self.animationLabel.animationDuration = duration.floatValue;
    self.animationLabel.animationDelay = delayTime.floatValue;
    if (animationType.integerValue != 0) {
        self.animationLabel.onlyDrawDirtyArea = YES;
        self.animationLabel.layerBased = NO;
        self.animationStyle = animationType.integerValue - 10;
        switch ((animationType.integerValue - 10)) {
            case 0:
                object_setClass(self.animationLabel, [ZCThrownLabel class]);
                break;
            case 1:
                object_setClass(self.animationLabel, [ZCShapeshiftLabel class]);
                break;
            case 2:
                object_setClass(self.animationLabel, [ZCAnimatedLabel class]);
                break;
            case 3:
                object_setClass(self.animationLabel, [ZCDuangLabel class]);
                break;
            case 4:
                object_setClass(self.animationLabel, [ZCFallLabel class]);
                break;
            case 5:
                object_setClass(self.animationLabel, [ZCTransparencyLabel class]);
                break;
            case 6:
                object_setClass(self.animationLabel, [ZCFlyinLabel class]);
                break;
            case 7:
                object_setClass(self.animationLabel, [ZCFocusLabel class]);
                break;
            case 8:
                object_setClass(self.animationLabel, [ZCRevealLabel class]);
                break;
            case 9:
                object_setClass(self.animationLabel, [ZCSpinLabel class]);
                self.animationLabel.layerBased = YES;
                break;
            case 10:
                object_setClass(self.animationLabel, [ZCDashLabel class]);
                self.animationLabel.layerBased = YES;
                break;
            default:
                break;
        }
        [self.animationLabel setNeedsDisplay];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.animationLabel setAttributedString:self.animationLabel.attributedString];
            [self.animationLabel startAppearAnimation];
        });
    }
}

#pragma mark - lazy
- (ZCAnimatedLabel *)animationLabel {
    if (!_animationLabel) {
        _animationLabel = [[ZCAnimatedLabel alloc] init];
    }
    return _animationLabel;
}

- (UIButton *)animationSettingBtn {
    if (!_animationSettingBtn) {
        _animationSettingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return _animationSettingBtn;
}

- (AnimationLabelSettingView *)settingView {
    if (!_settingView) {
        _settingView = [[[NSBundle mainBundle] loadNibNamed:@"AnimationLabelSettingView" owner:nil options:nil] firstObject];
    }
    return _settingView;
}

@end
