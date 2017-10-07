//
//  Content.m
//  Chatory
//
//  Created by askstory on 2017. 9. 25..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "Content.h"

@implementation Content

+(id)getContentWithKey:(NSString *)contentKey withTeacherKey:(NSString *)teacherKey {
    return [[Content alloc] initWithContentKey:contentKey withTeacherKey:teacherKey];
}


-(id)initWithContentKey:(NSString *)contentKey withTeacherKey:(NSString *)teacherKey {
    if (self = [super init]) {
        _teacher = [Teacher getTeacherWithKey:teacherKey];
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        if ([contentKey isEqualToString:CONTENT_KEY_01]) {
            [tempArray addObject:[Question getQuestionWithKey:QUESTION_KEY_01 withTeacherKey:_teacher]];
            [tempArray addObject:[Question getQuestionWithKey:QUESTION_KEY_02 withTeacherKey:_teacher]];
            [tempArray addObject:[Question getQuestionWithKey:QUESTION_KEY_03 withTeacherKey:_teacher]];
        }
        
        _array_Question = [[NSArray alloc] initWithArray:tempArray];
    }
    return self;
}

@end
