//
//  DrawingBoardImageView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "DrawingBoardImageView.h"
#import "DrawingBoardCanvasView.h"

@interface DrawingBoardImageView ()

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) DrawingBoardCanvasView *drawView;

@end

@implementation DrawingBoardImageView

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (instancetype)init {
    if (self = [super init]) {
        [self addControl];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) {
        [self addControl];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addControl];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self addControl];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.drawView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

#pragma mark - public methods
- (void)clearScreen {
    [self.drawView clearScreenOperation];
}

- (void)revokeScreen {
    [self.drawView revocationOperation];
}

- (void)eraseScreen {
    [self.drawView changeBlendModeInErase:kCGBlendModeDestinationIn];
    [self.drawView eraseScreenOperation];
}

- (void)stopEraseScreen {
    [self.drawView changeBlendModeInErase:kCGBlendModeNormal];
    [self.drawView stopEraseScreenOperation];
}

- (void)setStrokeColor:(UIColor *)lineColor {
    [self.drawView changeBrushColor:lineColor];
}

- (void)setStrokeWidth:(CGFloat)lineWidth {
    [self.drawView changeBrushWidth:lineWidth];
}

- (BOOL)saveGraffitiPictureToPhotoAlbum {
    UIImageWriteToSavedPhotosAlbum([self getImage], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    return YES;
}

- (UIImage *)getImage {
    
    //1.开启一个位图上下文
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1);
    //2.把画板上的内容渲染到上下文当中
    CGContextRef ctx =  UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    //3.从上下文当中取出一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - private methods
- (void)addControl {
    self.drawView = [[DrawingBoardCanvasView alloc] init];
    [self addSubview:_drawView];
    self.userInteractionEnabled = YES;
}

#pragma mark -- <保存到相册>
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"%@",error ? @"保存图片失败" : @"保存图片成功");
}

@end
