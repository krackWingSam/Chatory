//
//  TSSViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 26..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "TSSViewController.h"
#import "CTSpeechRecognizer.h"

@interface TSSViewController () <CTSpeechRecognizerDelegate> {
    IBOutlet UILabel *label;
    
    CTSpeechRecognizer *speechRecognizer;
}

@end

@implementation TSSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    speechRecognizer = [CTSpeechRecognizer sharedRecognizer];
    [speechRecognizer setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction
-(IBAction)action_Start:(id)sender {
    [speechRecognizer start];
}

-(IBAction)action_Stop:(id)sender {
    [speechRecognizer stop];
}

-(IBAction)action_Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - CTSpeechRecognizerDelegate
-(void)speechedText:(NSString *)string {
    [label setText:string];
}


@end
