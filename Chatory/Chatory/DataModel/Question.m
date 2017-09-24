//
//  Question.m
//  Chatory
//
//  Created by askstory on 2017. 9. 20..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "Question.h"

@implementation Question

-(id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        _dic = dic;
    }
    
    return self;
}

@end
