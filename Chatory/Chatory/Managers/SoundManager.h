//
//  SoundManager.h
//  Chatory
//
//  Created by askstory on 2017. 10. 1..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SoundID_Correct     = 1,
    SoundID_Wrong       = 2,
    
    SoundID_Choose      = 11,
    SoundID_Send        = 12,
    SoundID_Chat        = 13,
    SoundID_Select      = 14,
    
    SoundID_Forest      = 20
} SoundID;


@interface SoundManager : NSObject

+(SoundManager *)sharedManager;

-(void)playSoundWithSoundID:(SoundID)soundID;

@end
