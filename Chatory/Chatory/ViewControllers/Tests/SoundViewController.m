//
//  SoundViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 26..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "SoundViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SoundViewController () {
    AVPlayer *player;
}

@end

@implementation SoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"forest-1" ofType:@"m4a"];
    NSURL *url = [NSURL URLWithString:path];
    player = [[AVPlayer alloc] initWithURL:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions
-(IBAction)action_Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)action_Play:(id)sender {
    [player play];
}



@end
