//
//  Content.h
//  Chatory
//
//  Created by askstory on 2017. 9. 25..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"
#import "Teacher.h"

#define CONTENT_KEY_01 @"content_01"

@interface Content : NSObject

+(id)getContentWithKey:(NSString *)contentKey withTeacherKey:(NSString *)teacherKey;

@property (readonly) NSString *key;
@property (readonly) Teacher *teacher;
@property (readonly) NSArray *array_Question;

@property Question *currentQuestion;

@end
