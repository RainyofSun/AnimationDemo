//
//  DrawingBoardCanvasView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/5.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "DrawingBoardCanvasView.h"
#import "DrawingStroke.h"

static NSInteger containerCapacity = 256;

@interface DrawingBoardCanvasView ()
{
    CGMutablePathRef currentPath;
}
/** pathArray */
@property (nonatomic,strong) NSMutableArray <DrawingStroke *>*strokeArray;
/** totalArray */
@property (nonatomic,strong) NSMutableArray <NSMutableArray *>*totalArray;

/** lineWidth */
@property (nonatomic,assign) CGFloat lineWidth;
/** lineColor */
@property (nonatomic,strong) UIColor *lineColor;
/** isEarse */
@property (nonatomic,assign) BOOL isErase;
@property (nonatomic,assign) CGBlendMode blendMode;

@end

@implementation DrawingBoardCanvasView

- (instancetype)init {
    if (self = [super init]) {
        [self drawBoardInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self drawBoardInit];
    }
    return self;
}

- (void)dealloc {
    for (NSInteger i = 0; i < self.totalArray.count; i ++) {
        [self.totalArray[i] removeAllObjects];
    }
    [self.strokeArray removeAllObjects];
    [self.totalArray removeAllObjects];
    CGPathRelease(currentPath);
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    currentPath = CGPathCreateMutable();
    DrawingStroke *stroke = [[DrawingStroke alloc] init];
    stroke.path = currentPath;
    stroke.blendMode = self.blendMode;
    stroke.strokeWidth = _isErase ? 20.0 : self.lineWidth;
    stroke.lineColor = _isErase ? self.backgroundColor : self.lineColor;
    [self.strokeArray addObject:stroke];
    
    CGPoint point = [[touches anyObject] locationInView:self];
    CGPathMoveToPoint(currentPath, NULL, point.x, point.y);
    NSMutableArray *pointArray = [NSMutableArray array];
    [pointArray addObject:[NSValue valueWithCGPoint:point]];
    [self.totalArray addObject:pointArray];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [touches.anyObject locationInView:self];
    CGPathAddLineToPoint(currentPath, NULL, point.x, point.y);
    [self.totalArray.lastObject addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (DrawingStroke *stroke in self.strokeArray) {
        [stroke strokeWithContext:context];
    }
}

#pragma mark - public methods
// 清屏
- (void)clearScreenOperation {
    _isErase = NO;
    [self.strokeArray removeAllObjects];
    [self setNeedsDisplay];
}

// 撤销
- (void)revocationOperation {
    _isErase = NO;
    if (self.strokeArray.count) {
        [self.totalArray removeLastObject];
        [self.strokeArray removeLastObject];
        [self setNeedsDisplay];
    }
}

// 擦除
- (void)eraseScreenOperation {
    self.isErase = YES;
}

// 停止擦除
- (void)stopEraseScreenOperation {
    self.isErase = NO;
}

- (BOOL)saveTrajectory {
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:containerCapacity];
    for (NSMutableArray *tempArray in self.totalArray) {
        for (NSValue *tempValue in tempArray) {
            NSString *pointStr = [NSString stringWithFormat:@"%f,%f",[tempValue CGPointValue].x,[tempValue CGPointValue].y];
            [temp addObject:pointStr];
        }
    }
    
    NSString *plistPath = [self sandBoxFileAddress];
    return [temp writeToFile:plistPath atomically:YES];
}

- (NSArray<NSValue *> *)readTrajectory {
    NSString *plistPath = [self sandBoxFileAddress];
    NSMutableArray *tempArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    
    NSMutableArray *rs = [NSMutableArray arrayWithCapacity:containerCapacity];
    for (NSString *tempStr in tempArray) {
        NSArray *sa = [tempStr componentsSeparatedByString:@","];
        if (sa.count == 2) {
            [rs addObject:[NSValue valueWithCGPoint:CGPointMake([sa.firstObject floatValue], [sa.lastObject floatValue])]];
        }
    }
    return [rs copy];
}

// 画笔宽度
- (void)changeBrushWidth:(CGFloat)brushWidth {
    self.isErase = NO;
    self.lineWidth = MIN(MAX(1.0, brushWidth), 20.0);
}

// 画笔颜色
- (void)changeBrushColor:(UIColor *)brushColor {
    self.isErase = NO;
    self.lineColor = brushColor;
    [self setNeedsDisplay];
}

// 设置背景色
- (void)setDrawingBoardBackgroudColor:(UIColor *)bgColor {
    self.backgroundColor = bgColor;
}

// 修改线条模式
- (void)changeBlendModeInErase:(CGBlendMode)blendModel {
    self.blendMode = blendModel;
}

#pragma mark - private methods
- (void)drawBoardInit {
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 5.f;
    self.clipsToBounds = YES;
    self.lineWidth = 5.0;
    self.lineColor = [UIColor blackColor];
    self.isErase = NO;
    self.blendMode = kCGBlendModeNormal;
}

- (NSString *)sandBoxFileAddress {
    NSString *sandBox = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *plistPath = [sandBox stringByAppendingString:@"/line.plist"];
    return plistPath;
}

#pragma mark - lazy
- (NSMutableArray<DrawingStroke *> *)strokeArray {
    if (!_strokeArray) {
        _strokeArray = [NSMutableArray array];
    }
    return _strokeArray;
}

- (NSMutableArray<NSMutableArray *> *)totalArray {
    if (!_totalArray) {
        _totalArray = [NSMutableArray array];
    }
    return _totalArray;
}

@end
