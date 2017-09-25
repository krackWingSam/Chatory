//
//  Teacher.m
//  Chatory
//
//  Created by askstory on 2017. 9. 20..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher

+(id)getTeacherWithKey:(NSString *)key {
    return [[Teacher alloc] initWithKey:key];
}


-(id)initWithKey:(NSString *)key {
    if (self = [super init]) {
        if ([key isEqualToString:TEACHER_KEY_TIGER]) {
            _icon = [UIImage imageNamed:@"Teacher_icon"];
            
            NSString *gifImagePath = [[NSBundle mainBundle] pathForResource:@"Q01_correct" ofType:@"gif"];
            NSData *gifData = [[NSData alloc] initWithContentsOfFile:gifImagePath];
            _currectImage = [AnimatedGif getAnimationForGifWithData:gifData];
            
            NSArray *nameArray = @[@"Q01_wrong01", @"Q01_wrong02", @"Q01_wrong03"];
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for (NSString *name in nameArray) {
                NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
                NSData *tempData = [[NSData alloc] initWithContentsOfFile:path];
                AnimatedGif *tempGif = [AnimatedGif getAnimationForGifWithData:tempData];
                
                [tempArray addObject:tempGif];
            }
            
            _array_WrongImage = [[NSArray alloc] initWithArray:tempArray];
        }
    }
    return self;
}


@end
