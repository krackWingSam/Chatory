//
//  TestVideoViewController.m
//  Chatory
//
//  Created by askstory on 2017. 10. 8..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "TestVideoViewController.h"
#import <AVKit/AVKit.h>

@interface TestVideoViewController () {
    AVPlayerViewController *playerVC;
}

@end

@implementation TestVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    playerVC = [[AVPlayerViewController alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"v1" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AVPlayer *player = [[AVPlayer alloc] initWithURL:url];
    [player prepareForInterfaceBuilder];
    
    [playerVC setPlayer:player];
    
//    [self performSelector:@selector(load) withObject:nil afterDelay:5.f];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)load {
//    [self.navigationController pushViewController:playerVC animated:YES];
    [playerVC.view setFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:playerVC.view];
}

@end
