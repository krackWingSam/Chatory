//
//  Question.h
//  Chatory
//
//  Created by askstory on 2017. 9. 20..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Teacher.h"

#define QUESTION_KEY_01 @"question_key_01"
#define QUESTION_KEY_02 @"question_key_02"


@interface Question : NSObject

+(id)getQuestionWithKey:(NSString *)questionKey withTeacherKey:(Teacher *)teacher;

-(BOOL)isAnswer:(NSString *)string_Answer;

@property (readonly) NSString *key;
@property (readonly) Teacher *teacher;
@property (readonly) UIViewController *questionViewController;
@property (readonly) UIViewController *answerViewController;
@property (readonly) NSString *string_Answer;

@end
