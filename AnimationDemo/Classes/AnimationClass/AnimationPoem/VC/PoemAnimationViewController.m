//
//  PoemAnimationViewController.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "PoemAnimationViewController.h"
#import "AnimationPoemVM.h"

@interface PoemAnimationViewController ()

/** poemVM */
@property (nonatomic,strong) AnimationPoemVM *poemVM;

@end

@implementation PoemAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addBackground];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    self.view.layer.contents = nil;
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)addBackground {
    UIImage *contentsImg = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.jpeg"]];
    self.view.layer.contents = (__bridge id)contentsImg.CGImage;
    [self.poemVM setupPoemView:self];
}

#pragma mark - lazy
- (AnimationPoemVM *)poemVM {
    if (!_poemVM) {
        _poemVM = [[AnimationPoemVM alloc] init];
    }
    return _poemVM;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
