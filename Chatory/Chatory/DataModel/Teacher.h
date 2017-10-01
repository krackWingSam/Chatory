//
//  Teacher.h
//  Chatory
//
//  Created by askstory on 2017. 9. 20..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Animated-Gif-iOS/AnimatedGif.h>

#define TEACHER_KEY_TIGER @"teacher_tiger"

@interface Teacher : NSObject

+(id)getTeacherWithKey:(NSString *)key;

-(AnimatedGif *)getRightImage;
-(AnimatedGif *)getWrongImage;

@property (readonly) NSString *key;
@property (readonly) UIImage *icon;
@property (readonly) NSArray *array_RightImage;
@property (readonly) NSArray *array_WrongImage;

@end
