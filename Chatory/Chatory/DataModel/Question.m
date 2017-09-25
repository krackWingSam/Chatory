//
//  Question.m
//  Chatory
//
//  Created by askstory on 2017. 9. 20..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "Question.h"

@implementation Question

+(id)getQuestionWithKey:(NSString *)questionKey withTeacherKey:(Teacher *)teacher {
    return [[Question alloc] initWithQuestionKey:questionKey withTeacher:teacher];
}

-(id)initWithQuestionKey:(NSString *)key withTeacher:(Teacher *)teacher {
    if (self = [super init]) {
        if ([key isEqualToString:QUESTION_KEY_01]) {
            _key = key;
            _teacher = teacher;
        }
    }
    return self;
}


@end
