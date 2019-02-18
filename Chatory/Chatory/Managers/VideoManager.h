//
//  VideoManager.h
//  Chatory
//
//  Created by askstory on 2017. 10. 19..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoManager : NSObject

+(VideoManager *)sharedManager;


@property NSArray *array_Player;

@end
