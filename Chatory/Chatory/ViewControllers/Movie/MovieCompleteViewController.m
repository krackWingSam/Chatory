//
//  MovieCompleteViewController.m
//  Chatory
//
//  Created by askstory on 2017. 10. 9..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "MovieCompleteViewController.h"

@interface MovieCompleteViewController ()

@end

@implementation MovieCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions
-(IBAction)action_Back:(id)sender {
    [[SoundManager sharedManager] playSoundWithSoundID:SoundID_Select];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)action_Select:(id)sender {
    [[SoundManager sharedManager] playSoundWithSoundID:SoundID_Select];
}


#pragma mark - Override
-(BOOL)prefersStatusBarHidden {
    return YES;
}


@end
