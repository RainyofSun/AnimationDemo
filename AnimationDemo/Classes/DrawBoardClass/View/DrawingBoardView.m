//
//  DrawingBoardView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "DrawingBoardView.h"
#import "DrawingBoardCanvasView.h"
#import "BrushWidthSliderView.h"
#import "BrushColorView.h"

@interface DrawingBoardView ()

/** canvasView */
@property (nonatomic,strong) DrawingBoardCanvasView *canvasView;

@end

@implementation DrawingBoardView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupCanvasView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.canvasView.frame = CGRectMake(10, 20, CGRectGetWidth(self.bounds) - 20, CGRectGetHeight(self.bounds) - 120);
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (BOOL)saveTrajectory {
    return [self.canvasView saveTrajectory];
}

- (void)revocationOperation {
    [self.canvasView revocationOperation];
}

- (void)clearScreenOperation {
    [self.canvasView clearScreenOperation];
}

- (void)eraseScreenOperation {
    [self.canvasView eraseScreenOperation];
}

- (void)stopEraseScreenOperation {
    [self.canvasView stopEraseScreenOperation];
}

- (void)addChangeBrushWidthView {
    BrushWidthSliderView *brushWidthSliderView = [[[NSBundle mainBundle] loadNibNamed:@"BrushWidthSliderView" owner:nil options:nil] firstObject];
    [self addSubview:brushWidthSliderView];
    [brushWidthSliderView showBrushWidthView];
}

- (void)addBrushColorView {
    BrushColorView *colorView = [[BrushColorView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenWidth + 60)];
    [self addSubview:colorView];
    [colorView showColorView];
}

#pragma mark - Target
- (IBAction)touchDrawBoardBtn:(UIButton *)sender {
    if (self.DrawBoardCallBack) {
        self.DrawBoardCallBack(sender.tag);
    }
}

#pragma mark - 消息透传
- (void)ChangeBrushWidth:(NSNumber *)brushWidth {
    [self.canvasView changeBrushWidth:brushWidth.floatValue];
}

- (void)ChangeBrushColor:(UIColor *)brushColor {
    [self.canvasView changeBrushColor:brushColor];
}

#pragma mark - private methods
- (void)setupCanvasView {
    self.canvasView = [[DrawingBoardCanvasView alloc] init];
    [self addSubview:self.canvasView];
    [self.canvasView setDrawingBoardBackgroudColor:[UIColor lightGrayColor]];
}

@end
