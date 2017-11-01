//
//  SoundManager.m
//  Chatory
//
//  Created by askstory on 2017. 10. 1..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "SoundManager.h"
#import <AudioToolbox/AudioToolbox.h>

@interface SoundManager () {
    SystemSoundID sound_Currect;
    SystemSoundID sound_Wrong;
    SystemSoundID sound_Choose;
    SystemSoundID sound_Send;
    SystemSoundID sound_Chat;
    SystemSoundID sound_Forest;
    
    SystemSoundID sound_Select;
}

@end


@implementation SoundManager

+(SoundManager *)sharedManager {
    static SoundManager *sharedInstance = nil;
    if (nil == sharedInstance) {
        @synchronized(self) {
            if (nil == sharedInstance) {
                sharedInstance = [[SoundManager alloc] init];
            }
        }
    }
    
    return sharedInstance;
}

-(id)init {
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"answer_correct" ofType:@"wav"];
        CFURLRef url = (__bridge CFURLRef)[NSURL URLWithString:path];
        AudioServicesCreateSystemSoundID(url, &sound_Currect);
        
        path = [[NSBundle mainBundle] pathForResource:@"answer_wrong" ofType:@"wav"];
        url = (__bridge CFURLRef)[NSURL URLWithString:path];
        AudioServicesCreateSystemSoundID(url, &sound_Wrong);
        
        path = [[NSBundle mainBundle] pathForResource:@"choose" ofType:@"wav"];
        url = (__bridge CFURLRef)[NSURL URLWithString:path];
        AudioServicesCreateSystemSoundID(url, &sound_Choose);
        
        path = [[NSBundle mainBundle] pathForResource:@"send" ofType:@"wav"];
        url = (__bridge CFURLRef)[NSURL URLWithString:path];
        AudioServicesCreateSystemSoundID(url, &sound_Send);
        
        path = [[NSBundle mainBundle] pathForResource:@"chat" ofType:@"wav"];
        url = (__bridge CFURLRef)[NSURL URLWithString:path];
        AudioServicesCreateSystemSoundID(url, &sound_Chat);
        
        path = [[NSBundle mainBundle] pathForResource:@"forest" ofType:@"wav"];
        url = (__bridge CFURLRef)[NSURL URLWithString:path];
        AudioServicesCreateSystemSoundID(url, &sound_Forest);
        
        path = [[NSBundle mainBundle] pathForResource:@"chat" ofType:@"wav"];
        url = (__bridge CFURLRef)[NSURL URLWithString:path];
        AudioServicesCreateSystemSoundID(url, &sound_Select);
    }
    return self;
}


#pragma mark - public
-(void)playSoundWithSoundID:(SoundID)soundID {
    SystemSoundID currentID;
    switch (soundID) {
        case SoundID_Correct:
            currentID = sound_Currect;
            break;
            
        case SoundID_Wrong:
            currentID = sound_Wrong;
            break;
            
        case SoundID_Choose:
            currentID = sound_Choose;
            break;
            
        case SoundID_Send:
            currentID = sound_Send;
            break;
            
        case SoundID_Chat:
            currentID = sound_Chat;
            break;
            
        case SoundID_Select:
            currentID = sound_Select;
            break;
            
        case SoundID_Forest:
            currentID = sound_Forest;
            break;
            
        default:
            break;
    }
    
    AudioServicesPlaySystemSound(currentID);
}


@end
