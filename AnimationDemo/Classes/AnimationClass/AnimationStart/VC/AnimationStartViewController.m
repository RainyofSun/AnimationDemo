//
//  AnimationStartViewController.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/7/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationStartViewController.h"
#import "UIViewController+BookCoverAnimation.h"
#import "ShiningLabel.h"
#import "AnimationStartVM.h"

@interface AnimationStartViewController ()<UINavigationControllerDelegate,TransitionGestureDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bookCover;
/** shiningLab */
@property (nonatomic,strong) ShiningLabel *shiningLab;
/** startVM */
@property (nonatomic,strong) AnimationStartVM *startVM;

@end

@implementation AnimationStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor orangeColor];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appActive:) name:AppEnterForegroundNotification object:nil];
    [self setupUI];
    [self.startVM setupBookAnimation:self.bookCover animationVC:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    [self.shiningLab restartAnimation];
}

- (void)setupUI {
    self.bookCover.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bookCover.layer.shadowOffset = CGSizeMake(0, 2.5);
    self.bookCover.layer.shadowOpacity = 0.3;
    self.bookCover.layer.shadowRadius = 10;
    self.bookCover.userInteractionEnabled = YES;
    
    self.shiningLab = [self.startVM setupShiningLabelAnimation];
    [self.view addSubview:self.shiningLab];
}

#pragma mark - Notification
- (void)appActive:(NSNotification *)notification {
    [self.shiningLab restartAnimation];
}

#pragma mark - lazy
- (AnimationStartVM *)startVM {
    if (!_startVM) {
        _startVM = [[AnimationStartVM alloc] init];
    }
    return _startVM;
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
