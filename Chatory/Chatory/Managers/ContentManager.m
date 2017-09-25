//
//  ContentManager.m
//  Chatory
//
//  Created by askstory on 2017. 9. 25..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "ContentManager.h"

@implementation ContentManager

+(id)getContentWithContentKey:(NSString *)contentKey withTeacherKey:(NSString *)teacherKey {
    return [Content getContentWithKey:contentKey withTeacherKey:teacherKey];
}

@end
