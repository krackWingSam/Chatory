//
//  MovieViewController.m
//  Chatory
//
//  Created by askstory on 2017. 10. 7..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "MovieViewController.h"
#import <AVKit/AVKit.h>

@interface MovieViewController () {
    IBOutlet UIView *view_MovieFrame;
    IBOutlet UIScrollView *scroll_Script;
    IBOutlet UIActivityIndicatorView *indicator;
    
    IBOutlet UIView *view_Script01;
    
    IBOutlet UIImageView *imageView_01_01;
    IBOutlet UIImageView *imageView_01_02;
    IBOutlet UIImageView *imageView_01_03;
    IBOutlet UIImageView *imageView_01_04;
    IBOutlet UIImageView *imageView_01_05;
    IBOutlet UIImageView *imageView_01_06;
    IBOutlet UIImageView *imageView_01_07;
    
    IBOutlet UIButton *button_ScriptPlay_01_01;
    IBOutlet UIButton *button_ScriptPlay_01_02;
    IBOutlet UIButton *button_ScriptPlay_01_03;
    IBOutlet UIButton *button_ScriptPlay_01_04;
    IBOutlet UIButton *button_ScriptPlay_01_05;
    IBOutlet UIButton *button_ScriptPlay_01_06;
    IBOutlet UIButton *button_ScriptPlay_01_07;
    
    AVPlayerViewController *playerVC;
    
    NSArray *array_ScriptImageView;
    NSArray *array_ScriptOffImage;
    NSArray *array_ScriptOnImage;
    NSArray *array_ScriptTranslateImage;
    NSArray *array_ScriptButton;
    
    NSArray *array_Player;
    NSArray *array_ScriptView;
    
    BOOL isPlay;
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
    array_ScriptImageView = @[imageView_01_01, imageView_01_02, imageView_01_03, imageView_01_04, imageView_01_05, imageView_01_06, imageView_01_07];
    
    array_ScriptButton = @[button_ScriptPlay_01_01, button_ScriptPlay_01_02, button_ScriptPlay_01_03, button_ScriptPlay_01_04, button_ScriptPlay_01_05, button_ScriptPlay_01_06, button_ScriptPlay_01_07];
    
    array_ScriptView = @[view_Script01];
    
    playerVC = [[AVPlayerViewController alloc] init];
    [playerVC setShowsPlaybackControls:NO];
    
    [self switchMovie:0];
}

-(void)initImage {
    NSArray *names = @[@"#01_01_off", @"#01_02_off", @"#01_03_off", @"#01_04_off", @"#01_05_off", @"#01_06_off", @"#01_07_off"];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSString *name in names) {
        UIImage *tempImage = [UIImage imageNamed:name];
        [tempArray addObject:tempImage];
    }
    array_ScriptOffImage = [[NSArray alloc] initWithArray:tempArray];
    
    [tempArray removeAllObjects];
    names = @[@"#01_01_on", @"#01_02_on", @"#01_03_on", @"#01_04_on", @"#01_05_on", @"#01_06_on", @"#01_07_on"];
    for (NSString *name in names) {
        UIImage *tempImage = [UIImage imageNamed:name];
        [tempArray addObject:tempImage];
    }
    array_ScriptOnImage = [[NSArray alloc] initWithArray:tempArray];
    
    [tempArray removeAllObjects];
    names = @[@"#01_01_translation", @"#01_02_translation", @"#01_03_translation", @"#01_04_translation", @"#01_05_translation", @"#01_06_translation", @"#01_07_translation"];
    for (NSString *name in names) {
        UIImage *tempImage = [UIImage imageNamed:name];
        [tempArray addObject:tempImage];
    }
    array_ScriptTranslateImage = [[NSArray alloc] initWithArray:tempArray];
}

-(void)initMovie {
    NSArray *names = @[@"v1"];
    
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


#pragma mark - for Movie
-(void)switchMovie:(NSInteger)movieIndex {
    if (movieIndex >= [array_Player count])
        return;
    
    AVPlayer *currentPlayer = [array_Player objectAtIndex:movieIndex];
    if (currentPlayer.status != AVPlayerStatusReadyToPlay)
        return;
    
    [playerVC setPlayer:currentPlayer];
    
    [playerVC.view setFrame:CGRectMake(0, 0, view_MovieFrame.frame.size.width, view_MovieFrame.frame.size.height)];
    [view_MovieFrame addSubview:playerVC.view];
    
    for (UIView *view in array_ScriptView)
        [view removeFromSuperview];
    [scroll_Script addSubview:[array_ScriptView objectAtIndex:movieIndex]];
    [scroll_Script setContentSize:[[array_ScriptView objectAtIndex:movieIndex] frame].size];
}


#pragma mark - IBActions
-(IBAction)action_SliderMovie:(UISlider *)sender {
    [playerVC.player pause];
    
    int currentIndex = (int)[sender value];
    [sender setValue:(float)currentIndex + 1];
    [playerVC setPlayer:[array_Player objectAtIndex:currentIndex]];
}

-(IBAction)action_Translate:(UIButton *)sender {
    if (isPlay)
        return;
    
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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i=0 ; i<[array_ScriptButton count] ; i++) {
            UIButton *currentButton = [array_ScriptButton objectAtIndex:i];
            if (i == currentIndex)
                [currentButton setSelected:YES];
            else
                [currentButton setSelected:NO];
        }
    });
}


#pragma mark - Observing
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



@end
