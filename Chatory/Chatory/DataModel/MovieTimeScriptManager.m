//
//  MovieTimeScriptManager.m
//  Chatory
//
//  Created by askstory on 2017. 10. 9..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "MovieTimeScriptManager.h"

@interface MovieTimeScriptManager () {
    
}

@end

@implementation MovieTimeScriptManager

-(id)init {
    if (self = [super init]) {
        [self initTimeStruct];
    }
    return self;
}

-(void)initTimeStruct {
    NSArray *start = @[@0.f, @600.f, @922.f, @1211.f, @1402.f, @1628.f, @1904.f];
    NSArray *end = @[@600.f, @922.f, @1211.f, @1402.f, @1628.f, @1904.f, @2027.f];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i=0 ; i<[start count] ; i++) {
        NSUInteger startTime = [[start objectAtIndex:i] unsignedIntegerValue];
        NSUInteger endTime = [[end objectAtIndex:i] unsignedIntegerValue];
        NSRange range = NSMakeRange(startTime, endTime);
        [tempArray addObject:[NSValue valueWithRange:range]];
    }
    
    _array_ScriptRange = [[NSArray alloc] initWithArray:tempArray];
}

@end
