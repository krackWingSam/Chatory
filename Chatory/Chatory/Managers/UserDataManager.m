//
//  UserDataManager.m
//  Chatory
//
//  Created by askstory on 2017. 10. 7..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "UserDataManager.h"

@implementation UserDataManager

+(UserDataManager *)sharedManager {
    static UserDataManager *sharedInstance = nil;
    if (nil == sharedInstance) {
        @synchronized(self) {
            if (nil == sharedInstance) {
                sharedInstance = [[UserDataManager alloc] init];
            }
        }
    }
    
    return sharedInstance;
}

@end
