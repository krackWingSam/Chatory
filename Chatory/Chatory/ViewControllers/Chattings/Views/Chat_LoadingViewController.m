//
//  Chat_LoadingViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 27..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "Chat_LoadingViewController.h"

@interface Chat_LoadingViewController () {
    IBOutlet UIImageView *imageView_Icon;
    IBOutlet UIImageView *iamgeView_Dot1;
    IBOutlet UIImageView *iamgeView_Dot2;
    IBOutlet UIImageView *iamgeView_Dot3;
    
    NSInteger dotIndex;
    NSArray *array_Dot;
    
    BOOL isStop;
}

@end

@implementation Chat_LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initUI];
    isStop = NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    isStop = YES;
    dotIndex = 0;
}

-(void)initUI {
    isStop  = NO;
    
    array_Dot = @[iamgeView_Dot1, iamgeView_Dot2, iamgeView_Dot3];
    dotIndex = 0;
    
    for (UIImageView *imageView in array_Dot)
        [imageView setAlpha:0.f];
    
    [imageView_Icon setImage:_teacher.icon];
}


#pragma mark - Animations
-(void)showDotAnimation {
    if (isStop)
        return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImageView *imageView = [array_Dot objectAtIndex:dotIndex];
        [UIImageView animateWithDuration:0.2f animations:^{
            [imageView setAlpha:1.f];
        } completion:^(BOOL finished) {
            dotIndex += 1;
            if (dotIndex == [array_Dot count]) {
                dotIndex = 0;
                [self hideDotAnimation];
            }
            else
                [self showDotAnimation];
        }];
    });
}

-(void)hideDotAnimation {
    if (isStop)
        return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImageView *imageView = [array_Dot objectAtIndex:dotIndex];
        [UIImageView animateWithDuration:0.2f animations:^{
            [imageView setAlpha:0.f];
        } completion:^(BOOL finished) {
            dotIndex += 1;
            if (dotIndex == [array_Dot count]) {
                dotIndex = 0;
                
                if (self.delegate)
                    [self.delegate doneLoadingAnimation];
                else
                    [self showDotAnimation];
            }
            else
                [self hideDotAnimation];
        }];
    });
}


#pragma mark - properties
-(void)setShowIcon:(BOOL)showIcon {
    _showIcon = showIcon;
    
    [imageView_Icon setHidden:!_showIcon];
}



@end
