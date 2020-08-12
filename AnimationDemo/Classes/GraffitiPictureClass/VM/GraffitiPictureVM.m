//
//  GraffitiPictureVM.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "GraffitiPictureVM.h"
#import "GraffitiPictureView.h"

@interface GraffitiPictureVM ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/** graffitiPicView */
@property (nonatomic,strong) GraffitiPictureView *graffitiPicView;

@end

@implementation GraffitiPictureVM

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)setupGraffitiBoard:(UIViewController *)vc {
    self.graffitiPicView = [[[NSBundle mainBundle] loadNibNamed:@"GraffitiPictureView" owner:nil options:nil] firstObject];
    self.graffitiPicView.frame = vc.view.frame;
    [vc.view addSubview:self.graffitiPicView];
    [self blockCallBack];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.graffitiPicView updateGraffitiPicture:image];
}

#pragma mark - private methods
- (void)blockCallBack {
    WEAK_DEFINE(self);
    self.graffitiPicView.GraffitiBoardCallBack = ^(NSInteger senderTag) {
        switch (senderTag) {
            case 0:
                // 撤销
                [weak_self.graffitiPicView revocationOperation];
                break;
            case 1:
                // 画笔颜色
                [weak_self.graffitiPicView addBrushColorView];
                break;
            case 2:
                // 画笔宽度
                [weak_self.graffitiPicView addChangeBrushWidthView];
                break;
            case 3:
                // 清屏
                [weak_self.graffitiPicView clearScreenOperation];
                break;
            case 4:
                // 擦除
                [weak_self.graffitiPicView eraseScreenOperation];
                break;
            case 5:
                // 保存
                if ([weak_self.graffitiPicView saveTrajectory] && weak_self.NavBack) {
                    weak_self.NavBack();
                }
                break;
            case 6:
                // 继续作画
                [weak_self.graffitiPicView stopEraseScreenOperation];
                break;
            case 7:
                // 相册选取图片
                [weak_self selectPictureFromPhotoAblum];
                break;
            default:
                break;
        }
    };
}

- (void)selectPictureFromPhotoAblum {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePicker animated:YES completion:nil];
}

@end
