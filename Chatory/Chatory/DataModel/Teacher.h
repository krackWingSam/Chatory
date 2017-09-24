//
//  Teacher.h
//  Chatory
//
//  Created by askstory on 2017. 9. 20..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Teacher : NSObject

-(id)initWithDictionary:(NSDictionary *)dic;

@property (nonatomic, readonly) NSDictionary *dic;



@end
