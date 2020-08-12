//
//  GraffitiPictureView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "GraffitiPictureView.h"
#import "DrawingBoardImageView.h"
#import "BrushWidthSliderView.h"
#import "BrushColorView.h"

@interface GraffitiPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *graffitiPicImgView;
/** drawingBoardImgView */
@property (nonatomic,strong) DrawingBoardImageView *drawingBoardImgView;

@end

@implementation GraffitiPictureView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self graffitiPicInit];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (BOOL)saveTrajectory {
    return [self.drawingBoardImgView saveGraffitiPictureToPhotoAlbum];
}

- (void)revocationOperation {
    [self.drawingBoardImgView revokeScreen];
}

- (void)clearScreenOperation {
    [self.drawingBoardImgView clearScreen];
}

- (void)eraseScreenOperation {
    [self.drawingBoardImgView eraseScreen];
}

- (void)stopEraseScreenOperation {
    [self.drawingBoardImgView stopEraseScreen];
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

- (void)updateGraffitiPicture:(UIImage *)graffitiPic {
    self.drawingBoardImgView.image = graffitiPic;
}

#pragma mark - Target
- (IBAction)touchGraffitiViewBtn:(UIButton *)sender {
    if (self.GraffitiBoardCallBack) {
        self.GraffitiBoardCallBack(sender.tag);
    }
}

#pragma mark - 消息透传
- (void)ChangeBrushWidth:(NSNumber *)brushWidth {
    [self.drawingBoardImgView setStrokeWidth:brushWidth.floatValue];
}

- (void)ChangeBrushColor:(UIColor *)brushColor {
    [self.drawingBoardImgView setStrokeColor:brushColor];
}

#pragma mark - private methods
- (void)graffitiPicInit {
    self.drawingBoardImgView = [[DrawingBoardImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]];
    self.drawingBoardImgView.frame = CGRectMake(10, 20, ScreenWidth - 20, ScreenHeight - 200);
    [self addSubview:self.drawingBoardImgView];
}

@end
