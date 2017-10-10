//
//  TestSliderViewController.m
//  Chatory
//
//  Created by askstory on 2017. 10. 10..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "TestSliderViewController.h"

@interface TestSliderViewController ()

@end

@implementation TestSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions
-(IBAction)action_SliderValueChange:(UISlider *)sender {
    CGFloat floatValue = [sender value];
    if (floatValue > 0 && floatValue < 1.5) {
        
    }
}


@end
