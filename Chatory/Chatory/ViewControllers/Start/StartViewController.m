//
//  StartViewController.m
//  Chatory
//
//  Created by 상우 강 on 2017. 10. 26..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController () {
    IBOutlet UIButton *button;
}

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.5f animations:^{
        [button setAlpha:1.f];
    }];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [button setAlpha:0.f];
}


#pragma mark - IBActions
-(IBAction)action_Button:(UIButton *)button {
    [[SoundManager sharedManager] playSoundWithSoundID:SoundID_Select];
}


@end
