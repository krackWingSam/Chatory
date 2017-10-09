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
    //#1
    NSArray *start = @[@0.f, @600.f, @922.f, @1211.f, @1402.f, @1628.f, @1904.f];
    NSArray *end = @[@600.f, @922.f, @1211.f, @1402.f, @1628.f, @1904.f, @2027.f];
    
    NSMutableArray *allArray = [[NSMutableArray alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i=0 ; i<[start count] ; i++) {
        NSUInteger startTime = [[start objectAtIndex:i] unsignedIntegerValue];
        NSUInteger endTime = [[end objectAtIndex:i] unsignedIntegerValue];
        NSRange range = NSMakeRange(startTime, endTime);
        [tempArray addObject:[NSValue valueWithRange:range]];
    }
    [allArray addObject:tempArray];
    
    //#2
    tempArray = [[NSMutableArray alloc] init];
    start = @[@0.f, @301.f, @815.f, @1120.f];
    end = @[@301.f, @815.f, @1120.f, @1427];
    for (int i=0 ; i<[start count] ; i++) {
        NSUInteger startTime = [[start objectAtIndex:i] unsignedIntegerValue];
        NSUInteger endTime = [[end objectAtIndex:i] unsignedIntegerValue];
        NSRange range = NSMakeRange(startTime, endTime);
        [tempArray addObject:[NSValue valueWithRange:range]];
    }
    [allArray addObject:tempArray];
    
    //#3
    tempArray = [[NSMutableArray alloc] init];
    start = @[@0.f, @617, @820, @1111, @1511];
    end = @[@617, @820, @1111, @1511, @1720];
    for (int i=0 ; i<[start count] ; i++) {
        NSUInteger startTime = [[start objectAtIndex:i] unsignedIntegerValue];
        NSUInteger endTime = [[end objectAtIndex:i] unsignedIntegerValue];
        NSRange range = NSMakeRange(startTime, endTime);
        [tempArray addObject:[NSValue valueWithRange:range]];
    }
    [allArray addObject:tempArray];
    
    //#4
    tempArray = [[NSMutableArray alloc] init];
    start = @[@22, @315, @700, @1010, @1400, @1605];
    end = @[@315, @700, @1010, @1400, @1605, @1900];
    for (int i=0 ; i<[start count] ; i++) {
        NSUInteger startTime = [[start objectAtIndex:i] unsignedIntegerValue];
        NSUInteger endTime = [[end objectAtIndex:i] unsignedIntegerValue];
        NSRange range = NSMakeRange(startTime, endTime);
        [tempArray addObject:[NSValue valueWithRange:range]];
    }
    [allArray addObject:tempArray];
    
    //#5
    tempArray = [[NSMutableArray alloc] init];
    start = @[@0, @313, @604, @823];
    end = @[@313, @604, @823, @1323];
    for (int i=0 ; i<[start count] ; i++) {
        NSUInteger startTime = [[start objectAtIndex:i] unsignedIntegerValue];
        NSUInteger endTime = [[end objectAtIndex:i] unsignedIntegerValue];
        NSRange range = NSMakeRange(startTime, endTime);
        [tempArray addObject:[NSValue valueWithRange:range]];
    }
    [allArray addObject:tempArray];
    
    _array_ScriptRange = [[NSArray alloc] initWithArray:allArray];
    _array_VideoLength = @[@2200, @1800, @2000, @2000, @1400];
}

@end
