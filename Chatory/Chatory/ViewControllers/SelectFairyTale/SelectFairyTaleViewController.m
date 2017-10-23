//
//  SelectFairyTaleViewController.m
//  Chatory
//
//  Created by askstory on 2017. 10. 7..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "SelectFairyTaleViewController.h"
#import "UserDataManager.h"
#import <AVKit/AVKit.h>

@interface SelectFairyTaleViewController () <UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIView *contentView;
    
    IBOutlet UIView *view_Animated;
    IBOutlet UIImageView *imageView_OriginImage;
    
    IBOutlet UIView *view_Background;
    IBOutlet UIImageView *imageView_NewBackground;
    
    IBOutlet UIView *view_Popup;
    
    IBOutlet UIView *view_Menu;
    IBOutlet UIView *view_Script;
    
    
    UserDataManager *manager;
}

@end

@implementation SelectFairyTaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSError *error = nil;
    BOOL isSetOk = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback mode:AVAudioSessionModeMoviePlayback options:AVAudioSessionCategoryOptionMixWithOthers error:&error];
    if (!isSetOk)
        NSLog(@"AvAudio Session set Error : %@", error);
}

-(void)initUI {
    manager = [UserDataManager sharedManager];
    
    [scrollView addSubview:contentView];
    [scrollView setContentSize:contentView.frame.size];
    [scrollView setDelegate:self];
}


#pragma mark - Animation
-(void)startSwitchAnimation {
    [manager setContentKey:CONTENT_KEY_01];
    [scrollView removeFromSuperview];
    
    view_Background.layer.cornerRadius = 30.f;
    
    [self.view addSubview:view_Animated];
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = [imageView_OriginImage frame];
        frame.size.width -= frame.size.width / 10;
        frame.size.height -= frame.size.height / 10;
        frame.origin.x += frame.size.width / 20;
        frame.origin.y += frame.size.height / 20;
        [imageView_OriginImage setFrame:frame];
        NSLog(@"frame : %f, %f : %f, %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        [view_Background setAlpha:1.f];
        [UIView animateWithDuration:0.1f animations:^{
            [imageView_OriginImage setAlpha:0.f];
            [view_Background.layer setCornerRadius:0.f];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3f animations:^{
                [view_Background setFrame:view_Animated.frame];
                [imageView_NewBackground setFrame:view_Animated.frame];
            } completion:^(BOOL finished) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self startPopup];
                });
            }];
        }];
    }];
}

-(void)startPopup {
    [view_Popup setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:view_Popup];
    [UIView animateWithDuration:0.3f animations:^{
        [view_Popup setFrame:CGRectMake(0, -30, view_Popup.frame.size.width, view_Popup.frame.size.height)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2f animations:^{
            [view_Popup setFrame:CGRectMake(0, 0, view_Popup.frame.size.width, view_Popup.frame.size.height)];
        }];
    }];
}

-(void)startSwitchMovie {
    [UIView animateWithDuration:0.2f animations:^{
        [view_Popup setAlpha:0.f];
    } completion:^(BOOL finished) {
        [view_Script setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, view_Script.frame.size.height)];
        [self.view addSubview:view_Script];
        [UIView animateWithDuration:0.2f animations:^{
            [view_Background setFrame:CGRectMake(0, -167, view_Background.frame.size.width, view_Background.frame.size.height)];
            [view_Script setFrame:CGRectMake(0, self.view.frame.size.height - 167, view_Script.frame.size.width, view_Script.frame.size.height)];
        } completion:^(BOOL finished) {
            [view_Menu setAlpha:0.f];
            [view_Menu setFrame:CGRectMake(0, 0, view_Menu.frame.size.width, view_Menu.frame.size.height)];
            [self.view addSubview:view_Menu];
            [UIView animateWithDuration:0.2f animations:^{
                [view_Menu setAlpha:1.f];
            } completion:^(BOOL finished) {
                [self performSegueWithIdentifier:@"ShowMovieSegue" sender:nil];
            }];
        }];
    }];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)_scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat targetX = scrollView.contentOffset.x + velocity.x * 60.0;
    CGFloat indexWidth = contentView.frame.size.width / 4;
    CGFloat indexMargin = indexWidth / 2;
    CGFloat moveToX = 0;
    
    targetContentOffset->x = _scrollView.contentOffset.x;
    
    if (targetX < indexWidth - indexMargin)
        moveToX = 0;
    else if (targetX > indexWidth * 2 - indexMargin && targetX < indexWidth * 3 - indexMargin)
        moveToX = indexWidth * 2;
    else if (targetX > indexWidth * 3 - indexMargin && targetX < indexWidth * 4 - indexMargin)
        moveToX = scrollView.contentSize.width - scrollView.frame.size.width;
    else
        moveToX = 378-43;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2f animations:^{
            [_scrollView setContentOffset:CGPointMake(moveToX, 0)];
        }];
    });
}


#pragma mark - IBActions
-(IBAction)action_Select:(UIButton *)sender {
    [[SoundManager sharedManager] playSoundWithSoundID:SoundID_Select];
    NSLog(@"select tale : %d", (int)sender.tag);
    switch (sender.tag) {
        case 0:
            [self startSwitchAnimation];
            break;
            
        case 1:
            break;
            
        case 2:
            break;
            
        default:
            break;
    }
}

-(IBAction)action_Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)action_Movie:(id)sender {
    [[SoundManager sharedManager] playSoundWithSoundID:SoundID_Select];
    [self startSwitchMovie];
}

-(IBAction)action_Question:(id)sender {
    [[SoundManager sharedManager] playSoundWithSoundID:SoundID_Select];
    [self performSegueWithIdentifier:@"ShowChatSegue" sender:nil];
}


#pragma mark - Override
-(BOOL)prefersStatusBarHidden {
    return YES;
}


@end
