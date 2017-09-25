//
//  Chat_AnswerSheetViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 25..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "Chat_AnswerSheetViewController.h"

@interface Chat_AnswerSheetViewController () {
    IBOutlet UIView *view_Select;
    IBOutlet UITextField *tf_Question_01_01;
    
    IBOutlet UIView *view_Question_01_01;
    
    NSString *currentAnswer;
}

@end

@implementation Chat_AnswerSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initUI];
}

-(void)initUI {
    if ([_question.key isEqualToString:QUESTION_KEY_01]) {
        CGRect frame = [[UIScreen mainScreen] bounds];
        [self.view setFrame:CGRectMake(0, frame.size.height - view_Select.frame.size.height, frame.size.width, view_Select.frame.size.height)];
        [self.view addSubview:view_Select];
        [view_Question_01_01 setFrame:CGRectMake(view_Select.frame.size.width/2 - view_Question_01_01.frame.size.width/2, 15, view_Question_01_01.frame.size.width, view_Question_01_01.frame.size.height)];
        [view_Select addSubview:view_Question_01_01];
    }
}


#pragma mark - IBActions
-(IBAction)action_Send:(id)sender {
    [self.delegate isRightAnswer:currentAnswer];
}

-(IBAction)action_Select:(UIButton *)sender {
    if ([_question.key isEqualToString:QUESTION_KEY_01]) {
        [tf_Question_01_01 setText:[sender restorationIdentifier]];
        currentAnswer = [sender restorationIdentifier];
    }
}



@end
