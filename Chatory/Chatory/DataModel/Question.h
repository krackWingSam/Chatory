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


@interface Question : NSObject

+(id)getQuestionWithKey:(NSString *)questionKey withTeacherKey:(Teacher *)teacher;

@property (readonly) NSString *key;
@property (readonly) Teacher *teacher;
@property (readonly) UIViewController *questionViewController;

@end
