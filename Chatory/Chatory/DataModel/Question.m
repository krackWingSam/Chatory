//
//  Question.m
//  Chatory
//
//  Created by askstory on 2017. 9. 20..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "Question.h"
#import "Chat_QuestionViewController.h"
#import "Chat_AnswerSheetViewController.h"

@implementation Question

+(id)getQuestionWithKey:(NSString *)questionKey withTeacherKey:(Teacher *)teacher {
    return [[Question alloc] initWithQuestionKey:questionKey withTeacher:teacher];
}

-(id)initWithQuestionKey:(NSString *)key withTeacher:(Teacher *)teacher {
    if (self = [super init]) {
        _key = key;
        _teacher = teacher;
        
        Chat_QuestionViewController *qVC = [[Chat_QuestionViewController alloc] initWithNibName:@"Chat_QuestionViewController" bundle:nil];
        [qVC setQuestion:self];
        _questionViewController = qVC;
        
        Chat_AnswerSheetViewController *aVC = [[Chat_AnswerSheetViewController alloc] initWithNibName:@"Chat_AnswerSheetViewController" bundle:nil];
        [aVC setQuestion:self];
        _answerViewController = aVC;
        
        if ([key isEqualToString:QUESTION_KEY_01]) {
            _string_Answer = @"hop";
        }
        
        if ([key isEqualToString:QUESTION_KEY_02]) {
            _string_Answer = @"Forest";
            _string_Answer2 = @"forest";
        }
        
        if ([key isEqualToString:QUESTION_KEY_03]) {
            _string_Answer = @"Race";
            _string_Answer = @"race";
        }
    }
    return self;
}

-(BOOL)isAnswer:(NSString *)string_Answer {
    BOOL isAnswer = NO;
    if ([_string_Answer isEqualToString:string_Answer] || [_string_Answer2 isEqualToString:string_Answer])
        isAnswer = YES;
    
    return isAnswer;
}


@end
