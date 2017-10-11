//
//  MovieViewController.m
//  Chatory
//
//  Created by askstory on 2017. 10. 7..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "MovieViewController.h"
#import <AVKit/AVKit.h>

#import "MovieTimeScriptManager.h"

@interface MovieViewController () {
    AVPlayerViewController *playerVC;
    
    NSArray *array_VideoTitle;
    
    NSArray *array_ScriptImageView;
    NSArray *array_ScriptOffImage;
    NSArray *array_ScriptOnImage;
    NSArray *array_ScriptTranslateImage;
    NSArray *array_ScriptButton;
    NSArray *array_TranslateButton;
    
    NSArray *array_Player;
    NSArray *array_ScriptView;
    
    BOOL isAutoPlay;
    NSInteger currentVideoIndex;
    MovieTimeScriptManager *scriptTime;
    NSRange currentScriptRange;
    id timeObserver;
    dispatch_queue_t queue_TimeObserver;
}

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initMovie];
    [self initImage];
    [self initUI];
    
    [self showIndicator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)initUI {
    CGRect frame = [[UIScreen mainScreen] bounds];
    array_ScriptImageView = @[imageView_01_01, imageView_01_02, imageView_01_03, imageView_01_04, imageView_01_05, imageView_01_06, imageView_01_07,
                              imageView_02_01, imageView_02_02, imageView_02_03, imageView_02_04,
                              imageView_03_01, imageView_03_02, imageView_03_03, imageView_03_04, imageView_03_05,
                              imageView_04_01, imageView_04_02, imageView_04_03, imageView_04_04, imageView_04_05, imageView_04_06,
                              imageView_05_01, imageView_05_02, imageView_05_03, imageView_05_04];
    
    array_ScriptButton = @[button_ScriptPlay_01_01, button_ScriptPlay_01_02, button_ScriptPlay_01_03, button_ScriptPlay_01_04, button_ScriptPlay_01_05, button_ScriptPlay_01_06, button_ScriptPlay_01_07,
                           button_ScriptPlay_02_01, button_ScriptPlay_02_02, button_ScriptPlay_02_03, button_ScriptPlay_02_04,
                           button_ScriptPlay_03_01, button_ScriptPlay_03_02, button_ScriptPlay_03_03, button_ScriptPlay_03_04, button_ScriptPlay_03_05,
                           button_ScriptPlay_04_01, button_ScriptPlay_04_02, button_ScriptPlay_04_03, button_ScriptPlay_04_04, button_ScriptPlay_04_05, button_ScriptPlay_04_06,
                           button_ScriptPlay_05_01, button_ScriptPlay_05_02, button_ScriptPlay_05_03, button_ScriptPlay_05_04,];
    
    array_ScriptView = @[view_Script01, view_Script02, view_Script03, view_Script04, view_Script05];
    
    playerVC = [[AVPlayerViewController alloc] init];
    [playerVC setShowsPlaybackControls:NO];
    
    queue_TimeObserver = dispatch_queue_create("com.fermata.chatory.movie_time_seeker", DISPATCH_QUEUE_SERIAL);
    
    [view_VideoControl setFrame:CGRectMake(0, 0, frame.size.width, view_MovieFrame.frame.size.height)];
    
    [self switchMovie:0];
}

-(void)initImage {
    NSArray *names = @[@"#01_01_off", @"#01_02_off", @"#01_03_off", @"#01_04_off", @"#01_05_off", @"#01_06_off", @"#01_07_off",
                       @"#02_01_off", @"#02_02_off", @"#02_03_off", @"#02_04_off",
                       @"#03_01_off", @"#03_02_off", @"#03_03_off", @"#03_04_off", @"#03_05_off",
                       @"#04_01_off", @"#04_02_off", @"#04_03_off", @"#04_04_off", @"#04_05_off", @"#04_06_off",
                       @"#05_01_off", @"#05_02_off", @"#05_03_off", @"#05_04_off"];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSString *name in names) {
        UIImage *tempImage = [UIImage imageNamed:name];
        [tempArray addObject:tempImage];
    }
    array_ScriptOffImage = [[NSArray alloc] initWithArray:tempArray];
    
    [tempArray removeAllObjects];
    names =  @[@"#01_01_on", @"#01_02_on", @"#01_03_on", @"#01_04_on", @"#01_05_on", @"#01_06_on", @"#01_07_on",
               @"#02_01_on", @"#02_02_on", @"#02_03_on", @"#02_04_on",
               @"#03_01_on", @"#03_02_on", @"#03_03_on", @"#03_04_on", @"#03_05_on",
               @"#04_01_on", @"#04_02_on", @"#04_03_on", @"#04_04_on", @"#04_05_on", @"#04_06_on",
               @"#05_01_on", @"#05_02_on", @"#05_03_on", @"#05_04_on"];
    for (NSString *name in names) {
        UIImage *tempImage = [UIImage imageNamed:name];
        [tempArray addObject:tempImage];
    }
    array_ScriptOnImage = [[NSArray alloc] initWithArray:tempArray];
    
    [tempArray removeAllObjects];
    names = @[@"#01_01_translation", @"#01_02_translation", @"#01_03_translation", @"#01_04_translation", @"#01_05_translation", @"#01_06_translation", @"#01_07_translation",
              @"#02_01_translation", @"#02_02_translation", @"#02_03_translation", @"#02_04_translation",
              @"#03_01_translation", @"#03_02_translation", @"#03_03_translation", @"#03_04_translation", @"#03_05_translation",
              @"#04_01_translation", @"#04_02_translation", @"#04_03_translation", @"#04_04_translation", @"#04_05_translation", @"#04_06_translation",
              @"#05_01_translation", @"#05_02_translation", @"#05_03_translation", @"#05_04_translation"];
    for (NSString *name in names) {
        UIImage *tempImage = [UIImage imageNamed:name];
        [tempArray addObject:tempImage];
    }
    array_ScriptTranslateImage = [[NSArray alloc] initWithArray:tempArray];
    
    names = @[@"movie_nav_1", @"movie_nav_2", @"movie_nav_3", @"movie_nav_4", @"movie_nav_5"];
    [tempArray removeAllObjects];
    for (NSString *name in names) {
        UIImage *tempImage = [UIImage imageNamed:name];
        [tempArray addObject:tempImage];
    }
    array_VideoTitle = [[NSArray alloc] initWithArray:tempArray];
}

-(void)initMovie {
    NSArray *names = @[@"v1", @"v2", @"v3", @"v4", @"v5"];
    isAutoPlay = NO;
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSString *name in names) {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"mp4"];
        NSURL *url = [NSURL fileURLWithPath:path];
        AVAsset *asset = [AVAsset assetWithURL:url];
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset:asset];
        AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:item];
        [player addObserver:self forKeyPath:@"status" options:0 context:nil];
        [tempArray addObject:player];
    }
    
    array_Player = [[NSArray alloc] initWithArray:tempArray];
    
    scriptTime = [[MovieTimeScriptManager alloc] init];
}

#pragma mark - MovieAutoPlayControl
-(void)startAutoPlay {
    isAutoPlay = YES;
    [self hideVideoControl];
    [playerVC.player seekToTime:CMTimeMake(0, 1) toleranceBefore:CMTimeMake(0, 1) toleranceAfter:CMTimeMake(0, 1)];
    [playerVC.player play];
}

-(void)stopAutoPlay {
    isAutoPlay = NO;
    [playerVC.player pause];
}


#pragma mark - Animations
-(void)showIndicator {
    [indicator setFrame:[[UIScreen mainScreen] bounds]];
    [indicator startAnimating];
    [self.view addSubview:indicator];
}

-(void)hideIndicator {
    [UIView animateWithDuration:0.2f animations:^{
        [indicator setAlpha:0.f];
    } completion:^(BOOL finished) {
        [indicator removeFromSuperview];
        [self switchMovie:0];
    }];
}

-(void)showVideoControl {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([view_VideoControl superview] == view_MovieFrame)
            return;
        
        [view_VideoControl setAlpha:0.f];
        [view_MovieFrame insertSubview:view_VideoControl belowSubview:slider];
        [UIView animateWithDuration:0.2f animations:^{
            [view_VideoControl setAlpha:1.f];
        }];
    });
}

-(void)hideVideoControl {
    [UIView animateWithDuration:0.2f animations:^{
        [view_VideoControl setAlpha:0.f];
    } completion:^(BOOL finished) {
        [view_VideoControl removeFromSuperview];
    }];
}


#pragma mark - for Movie
-(void)switchMovie:(NSInteger)movieIndex {
    if (movieIndex >= [array_Player count])
        return;
    
    [self removeTimeObserver];
    [self hideVideoControl];
    currentVideoIndex = movieIndex;
    
    AVPlayer *currentPlayer = [array_Player objectAtIndex:movieIndex];
    if (currentPlayer.status != AVPlayerStatusReadyToPlay)
        return;
    
    [playerVC setPlayer:currentPlayer];
    
    [self addTimeObserver];
    
    //set AVPlayerView frame
    
    [playerVC setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [playerVC.view setFrame:CGRectMake(0, 0, view_MovieFrame.frame.size.width, view_MovieFrame.frame.size.height)];
    [view_MovieFrame insertSubview:playerVC.view atIndex:0];
    
    for (UIView *view in array_ScriptView)
        [view removeFromSuperview];
    [scroll_Script addSubview:[array_ScriptView objectAtIndex:movieIndex]];
    [scroll_Script setContentSize:[[array_ScriptView objectAtIndex:movieIndex] frame].size];
    
    [imageView_VideoTitle setAlpha:1.f];
    [imageView_VideoTitle setImage:[array_VideoTitle objectAtIndex:currentVideoIndex]];
    [slider setValue:currentVideoIndex + 1];
    
    [self startAutoPlay];
}


#pragma mark - IBActions
-(IBAction)action_SliderMovie:(UISlider *)sender {
    [playerVC.player pause];
    
    int currentIndex = (int)[sender value];
    [sender setValue:(float)currentIndex + 1];
    [self switchMovie:currentIndex];
}

-(IBAction)action_Translate:(UIButton *)sender {
    NSInteger currentIndex = [sender tag];
    UIImageView *currentImageView = [array_ScriptImageView objectAtIndex:currentIndex];
    UIImage *currentTranslatedImage = [array_ScriptTranslateImage objectAtIndex:currentIndex];
    UIImage *currentOffImage = [array_ScriptOffImage objectAtIndex:currentIndex];
    if (currentTranslatedImage == currentImageView.image)
        [currentImageView setImage:currentOffImage];
    else
        [currentImageView setImage:currentTranslatedImage];
}

-(IBAction)action_PlayScript:(UIButton *)sender {
    NSInteger currentIndex = [sender tag];
    
    [self hideVideoControl];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i=0 ; i<[array_ScriptButton count] ; i++) {
            UIButton *currentButton = [array_ScriptButton objectAtIndex:i];
            if (i == currentIndex)
                [currentButton setSelected:YES];
            else
                [currentButton setSelected:NO];
        }
        
        isAutoPlay = NO;
        NSArray *currentScriptTime = [scriptTime.array_ScriptRange objectAtIndex:currentVideoIndex];
        NSInteger removeCount = 0;
        NSInteger usingIndex = 0;
        for (int i=0 ; i<currentVideoIndex ; i++) {
            removeCount += [[scriptTime.array_ScriptRange objectAtIndex:i] count];
        }
        usingIndex = currentIndex - removeCount;
        
        currentScriptRange = [[currentScriptTime objectAtIndex:usingIndex] rangeValue];
        [playerVC.player seekToTime:CMTimeMake(currentScriptRange.location, 100) toleranceBefore:CMTimeMake(10, 100) toleranceAfter:CMTimeMake(10, 100)];
        [playerVC.player play];
        
        UIImageView *imageView = [array_ScriptImageView objectAtIndex:currentIndex];
        [imageView setImage:[array_ScriptOnImage objectAtIndex:currentIndex]];
    });
}

-(IBAction)action_Replay:(id)sender {
    [self startAutoPlay];
}

-(IBAction)action_Next:(id)sender {
    NSInteger nextVideoIndex = currentVideoIndex + 1;
    
    if (nextVideoIndex >= [array_Player count]) {
        currentVideoIndex -= 1;
        [self performSegueWithIdentifier:@"ShowCompleteSegue" sender:nil];
    }
    else
        [self switchMovie:nextVideoIndex];
}

-(IBAction)action_Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Observing
-(void)addTimeObserver {
    AVPlayer *currentPlayer = [playerVC player];
    
    timeObserver = [currentPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:queue_TimeObserver usingBlock:^(CMTime time) {
//        NSLog(@"time : %f", CMTimeGetSeconds(time));
        CGFloat currentSecond = CMTimeGetSeconds(time) * 100;
        
        if (isAutoPlay) {
            NSArray *currentScriptTime = [scriptTime.array_ScriptRange objectAtIndex:currentVideoIndex];
            for (NSValue *valueObject in currentScriptTime) {
                NSRange range = [valueObject rangeValue];
                CGFloat compareRangeStart = (CGFloat)range.location;
                CGFloat compareRangeEnd = (CGFloat)range.length;
                
                NSInteger currentIndex = [currentScriptTime indexOfObject:valueObject];
                NSInteger addedIndex = 0;
                for (int i=0 ; i<currentVideoIndex ; i++) {
                    addedIndex += [[scriptTime.array_ScriptRange objectAtIndex:i] count];
                }
                currentIndex += addedIndex;
                if (currentIndex >= 26)
                    currentIndex = 25;
                UIImageView *imageView = [array_ScriptImageView objectAtIndex:currentIndex];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (currentSecond >= compareRangeStart && currentSecond <= compareRangeEnd) {
                        [imageView setImage:[array_ScriptOnImage objectAtIndex:currentIndex]];
                        //check scroll offset
                        CGPoint currentOffset = [scroll_Script contentOffset];
                        UIButton *button = [array_ScriptButton objectAtIndex:currentIndex];
                        currentOffset.y = button.frame.origin.y + button.frame.size.height + 10 - scroll_Script.frame.size.height;
                        if (currentOffset.y < 0)
                            currentOffset.y = 0;
                        
                        [UIView animateWithDuration:0.2f animations:^{
                            [scroll_Script setContentOffset:currentOffset];
                        }];
                    }
                    else
                        [imageView setImage:[array_ScriptOffImage objectAtIndex:currentIndex]];
                });
            }
            
            CGFloat videoLength = [[scriptTime.array_VideoLength objectAtIndex:currentVideoIndex] floatValue];
            if (currentSecond >= videoLength - 50) {
                [self showVideoControl];
            }
        }
        else {
            CGFloat compareRangeStart = (CGFloat)currentScriptRange.location - 50;
            CGFloat compareRangeEnd = (CGFloat)currentScriptRange.length;
            if (currentSecond < compareRangeStart || currentSecond > compareRangeEnd) {
                [playerVC.player pause];
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (UIButton *button in array_ScriptButton)
                        [button setSelected:NO];
                    
                    for (int i=0 ; i<[array_ScriptImageView count] ; i++) {
                        UIImageView *imageView = [array_ScriptImageView objectAtIndex:i];
                        UIImage *image = [array_ScriptOffImage objectAtIndex:i];
                        [imageView setImage:image];
                    }
                });
            }
        }
    }];
}

-(void)removeTimeObserver {
    AVPlayer *currentPlayer = [playerVC player];
    
    if (timeObserver)
        [currentPlayer removeTimeObserver:timeObserver];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    NSLog(@"observing check");
    
    BOOL loadDone = YES;
    if ([keyPath isEqualToString:@"status"]) {
        for (AVPlayer *player in array_Player) {
            if (player.status != AVPlayerStatusReadyToPlay)
                loadDone = NO;
        }
    }
    
    if (loadDone) {
        NSLog(@"load done");
        [self hideIndicator];
    }
}


#pragma mark - Override
-(BOOL)prefersStatusBarHidden {
    return YES;
}



@end
