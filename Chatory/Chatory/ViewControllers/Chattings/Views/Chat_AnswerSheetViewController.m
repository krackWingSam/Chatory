//
//  Chat_AnswerSheetViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 25..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "Chat_AnswerSheetViewController.h"
#import "CTSpeechRecognizer.h"

@interface Chat_AnswerSheetViewController () <CTSpeechRecognizerDelegate> {
    IBOutlet UIView *view_Select;
    
    IBOutlet UIView *view_Question_01_01;
    IBOutlet UIView *view_Speak;
    IBOutlet UIView *view_Keyboard;
    
    CTSpeechRecognizer *speechRecognizer;
    
    NSString *currentAnswer;
}

@end

@implementation Chat_AnswerSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)initUI {
    speechRecognizer = [CTSpeechRecognizer sharedRecognizer];
    [speechRecognizer setDelegate:self];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    if ([_question.key isEqualToString:QUESTION_KEY_01]) {
        [self.view setFrame:CGRectMake(0, frame.size.height - view_Select.frame.size.height, frame.size.width, view_Select.frame.size.height)];
        [self.view addSubview:view_Select];
        [view_Question_01_01 setFrame:CGRectMake(view_Select.frame.size.width/2 - view_Question_01_01.frame.size.width/2, 15, view_Question_01_01.frame.size.width, view_Question_01_01.frame.size.height)];
        [view_Select addSubview:view_Question_01_01];
        
        _placeHolder = @"정답을 입력해주세요.";
    }
    if ([_question.key isEqualToString:QUESTION_KEY_02]) {
        [self.view setFrame:CGRectMake(0, frame.size.height - view_Speak.frame.size.height, frame.size.width, view_Speak.frame.size.height)];
        [self.view addSubview:view_Speak];
        
        _placeHolder = @"따라 읽어보세요.";
    }
    
    if ([_question.key isEqualToString:QUESTION_KEY_03]) {
        [self.view setFrame:CGRectMake(0, frame.size.height - view_Keyboard.frame.size.height, frame.size.width, view_Keyboard.frame.size.height)];
        [self.view addSubview:view_Keyboard];
        
        _placeHolder = @"정답을 입력해주세요.";
    }
}


#pragma mark - IBActions
-(IBAction)action_Select:(UIButton *)sender {
    if ([_question.key isEqualToString:QUESTION_KEY_01]) {
        currentAnswer = [sender restorationIdentifier];
    }
    [self.delegate selectAnswer:currentAnswer];
    
    [[SoundManager sharedManager] playSoundWithSoundID:SoundID_Choose];
}

-(IBAction)action_StartSpeak:(id)sender {
    [speechRecognizer start];
}

-(IBAction)action_StopSpeak:(id)sender {
    [speechRecognizer stop];
}


#pragma mark - CTSpeechRecognizer
-(void)speechedText:(NSString *)string {
    dispatch_async(dispatch_get_main_queue(), ^{
        currentAnswer = string;
        
        [self.delegate selectAnswer:currentAnswer];
    });
}



@end
