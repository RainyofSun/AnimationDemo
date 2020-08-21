//
//  PoemView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/21.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "PoemView.h"
#import "AlphaAnimationLabel.h"

@interface PoemView ()

/** poemSize */
@property (nonatomic,assign,readwrite) CGSize poemSize;
/** animationLabelArray */
@property (nonatomic,strong) NSMutableArray <AlphaAnimationLabel *>*animationLabelArray;
/** poemArray */
@property (nonatomic,strong) NSArray <NSString *>*poemArray;
/** animationIndex */
@property (nonatomic,assign) NSInteger animationIndex;

@end

@implementation PoemView

- (instancetype)init {
    if (self = [super init]) {
        [self initProperties];
        [self setupPoemLine];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)startAnimation {
    if (self.animationIndex >= self.animationLabelArray.count) {
        NSLog(@"动画执行完毕");
        return;
    }
    NSLog(@"index %ld",self.animationIndex);
    AlphaAnimationLabel *animationLab = self.animationLabelArray[self.animationIndex];
    [animationLab startAnimation];
    WEAK_DEFINE(self);
    animationLab.animationFinishBlock = ^(BOOL finish) {
        weak_self.animationIndex ++;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weak_self startAnimation];
        });
    };
}

#pragma mark - private methods
- (void)initProperties {
    self.animationIndex = 0;
    self.poemArray = @[@"樱花飞逝,风卷残月",
                       @"所谓伊人,何去何从",
                       @"谁比樱花笃,慧根谒真宗",
                       @"樱花一欢歌云作伴,余味载心头",
                       @"新韵因诗起,随心未敢兜"];
    self.animationLabelArray = [NSMutableArray arrayWithCapacity:self.poemArray.count];
    self.poemSize = CGSizeMake(3 * (self.poemArray.count + 1) + 20 * self.poemArray.count + 16, 400);
}

- (void)setupPoemLine {
    for (NSInteger i = 0; i < self.poemArray.count; i ++) {
        AlphaAnimationLabel *animationLabel = [[AlphaAnimationLabel alloc] initWithAlphaAnimationLabelFrame:CGRectMake(8 + 23 * i, 3, 20, 400)];
        animationLabel.text = self.poemArray[i];
        animationLabel.textColor = [UIColor whiteColor];
        animationLabel.font = PianPianFontSize(20);
        [self addSubview:[animationLabel alphaAnimationLabel]];
        [self.animationLabelArray addObject:animationLabel];
    }
}

@end
