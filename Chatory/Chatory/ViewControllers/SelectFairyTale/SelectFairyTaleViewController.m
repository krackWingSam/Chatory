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
    UserDataManager *manager;
    
    CGRect frame_view_Animated;
    CGRect frame_imageView_OriginImage;
    CGRect frame_view_Background;
    CGRect frame_imageView_NewBackground;
    CGRect frame_view_Script;
}

@end

@implementation SelectFairyTaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getFrames];
    [self initFrames];
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
    
    [self initFrames];
}

-(void)getFrames {
    frame_view_Animated = [view_Animated frame];;
    frame_imageView_OriginImage = [imageView_OriginImage frame];
    frame_view_Background = [view_Background frame];
    frame_imageView_NewBackground = [imageView_NewBackground frame];
    frame_view_Script = [view_Script frame];
}

-(void)initUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        manager = [UserDataManager sharedManager];
        
        [scrollView setAlpha:1.f];
        [scrollView addSubview:contentView];
        [scrollView setContentSize:contentView.frame.size];
        [scrollView setDelegate:self];
        
        [slider setValue:1.f];
        
        [view_Animated removeFromSuperview];
        [view_Menu removeFromSuperview];
        [view_Script removeFromSuperview];
        [view_Popup removeFromSuperview];
        
        [view_Menu addSubview:slider];
    });
}

-(void)initFrames {
    [view_Animated setFrame:frame_view_Animated];
    [imageView_OriginImage setFrame:frame_imageView_OriginImage];
    [view_Background setFrame:frame_view_Background];
    [imageView_NewBackground setFrame:frame_imageView_NewBackground];
    [view_Script setFrame:frame_view_Script];
    
    [self initUI];
}


#pragma mark - Animation
-(void)startSwitchAnimation {
    [manager setContentKey:CONTENT_KEY_01];
//    [scrollView removeFromSuperview];
    
    [view_Animated setFrame:frame_view_Animated];
    [imageView_OriginImage setFrame:frame_imageView_OriginImage];
    [view_Background setFrame:frame_view_Background];
    [imageView_NewBackground setFrame:frame_imageView_NewBackground];
    [view_Script setFrame:frame_view_Script];
    
    [imageView_OriginImage setAlpha:1.f];
    [imageView_NewBackground setAlpha:1.f];
    [view_Animated setAlpha:1.f];
    [scrollView setAlpha:0.f];
    
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
                [view_Animated setAlpha:1.f];
                CGRect frame = [view_Animated frame];
                [imageView_NewBackground setFrame:frame];
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
    [view_Popup setAlpha:1.f];
    [UIView animateWithDuration:0.3f animations:^{
        [view_Popup setFrame:CGRectMake(0, -30, view_Popup.frame.size.width, view_Popup.frame.size.height)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2f animations:^{
            [view_Popup setFrame:CGRectMake(0, 0, view_Popup.frame.size.width, view_Popup.frame.size.height)];
        }];
    }];
}

-(void)hidePopup {
    [UIView animateWithDuration:0.2f animations:^{
        [view_Popup setFrame:CGRectMake(0, -30, view_Popup.frame.size.width, view_Popup.frame.size.height)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f animations:^{
            [view_Popup setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
            [view_Animated setAlpha:0.f];
            [scrollView setAlpha:1.f];
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
            CGRect frame = [view_Animated frame];
            frame.origin.x += 8;
            frame.origin.y += 85;
            [imageView_NewBackground setFrame:frame];
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
    [[SoundManager sharedManager] playSoundWithSoundID:SoundID_Select];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)action_BackSelect:(id)sender {
    [self hidePopup];
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
