//
//  Question.h
//  Chatory
//
//  Created by askstory on 2017. 9. 20..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

-(id)initWithDictionary:(NSDictionary *)dic;


@property (nonatomic, readonly) NSDictionary *dic;

@property NSString *string_Question;
@property NSString *string_Answer;

@end
