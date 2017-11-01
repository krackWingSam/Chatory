//
//  UserDataManager.h
//  Chatory
//
//  Created by askstory on 2017. 10. 7..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataManager : NSObject

+(UserDataManager *)sharedManager;


@property NSString *teacherKey;
@property NSString *contentKey;

@end
