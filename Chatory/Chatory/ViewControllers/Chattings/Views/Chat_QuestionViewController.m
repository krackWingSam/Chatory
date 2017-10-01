//
//  Chat_QuestionViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 22..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "Chat_QuestionViewController.h"

@interface Chat_QuestionViewController () {
    IBOutlet UIView *view_Question_01_01a;
    IBOutlet UIView *view_Question_01_01b;
    IBOutlet UIView *view_Question_01_01c;

    IBOutlet UIView *view_Question_02a;
    IBOutlet UIView *view_Question_02b;
    
    IBOutlet UIView *view_Question_03a;
    IBOutlet UIView *view_Question_03b;
    
    AVAudioPlayer *player;
}

@end

@implementation Chat_QuestionViewController

-(void)initUI {
    [super initUI];
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    if ([self.question.key isEqualToString:QUESTION_KEY_01]) {
        [view_Question_01_01a setFrame:CGRectMake(0, 0, frame.size.width, view_Question_01_01a.frame.size.height)];
        [view_Question_01_01b setFrame:CGRectMake(0, 0, frame.size.width, view_Question_01_01b.frame.size.height)];
        [view_Question_01_01c setFrame:CGRectMake(0, 0, frame.size.width, view_Question_01_01c.frame.size.height)];
        array_Views = @[view_Question_01_01a, view_Question_01_01b, view_Question_01_01c];
    }
    
    if ([self.question.key isEqualToString:QUESTION_KEY_02]) {
        [view_Question_02a setFrame:CGRectMake(0, 0, frame.size.width, view_Question_02a.frame.size.height)];
        [view_Question_02b setFrame:CGRectMake(0, 0, frame.size.width, view_Question_02b.frame.size.height)];
        array_Views = @[view_Question_02a, view_Question_02b];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"forest-1" ofType:@"m4a"];
        NSURL *url = [NSURL URLWithString:path];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    }
    
    if ([self.question.key isEqualToString:QUESTION_KEY_03]) {
        [view_Question_03a setFrame:CGRectMake(0, 0, frame.size.width, view_Question_03a.frame.size.height)];
        [view_Question_03b setFrame:CGRectMake(0, 0, frame.size.width, view_Question_03b.frame.size.height)];
        
        array_Views = @[view_Question_03a, view_Question_03b];
    }
}


#pragma mark - IBActions
-(IBAction)action_PlayQuestion02:(id)sender {
    [[SoundManager sharedManager] playSoundWithSoundID:SoundID_Forest];
}

@end
