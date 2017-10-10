//
//  ViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 19..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
#ifdef DEV_MODE
    [self performSegueWithIdentifier:@"ShowDevModeSegue" sender:nil];
#else
    [self performSegueWithIdentifier:@"ShowMainSegue" sender:nil];
#endif
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}


@end
