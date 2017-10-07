//
//  ContentManager.h
//  Chatory
//
//  Created by askstory on 2017. 9. 25..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Content.h"

@interface ContentManager : NSObject

+(id)getContentWithContentKey:(NSString *)contentKey withTeacherKey:(NSString *)teacherKey;

@end
