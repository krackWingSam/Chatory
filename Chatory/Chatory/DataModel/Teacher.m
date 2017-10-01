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
            
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            NSArray *nameArray = @[@"Q01_correct01", @"Q02_correct02"];
            for (NSString *name in nameArray) {
                NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
                NSData *tempData = [[NSData alloc] initWithContentsOfFile:path];
                AnimatedGif *tempGif = [AnimatedGif getAnimationForGifWithData:tempData];
                
                [tempArray addObject:tempGif];
            }
            _array_RightImage = [[NSArray alloc] initWithArray:tempArray];
            
            nameArray = @[@"Q01_wrong01", @"Q01_wrong02", @"Q01_wrong03"];
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


#pragma mark - public
-(AnimatedGif *)getRightImage {
    int randNumber = rand() % [_array_RightImage count];
    return [_array_RightImage objectAtIndex:randNumber];
}

-(AnimatedGif *)getWrongImage {
    int randNumber = rand() % [_array_WrongImage count];
    return [_array_WrongImage objectAtIndex:randNumber];
}


@end
