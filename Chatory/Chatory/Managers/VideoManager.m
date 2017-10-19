//
//  VideoManager.m
//  Chatory
//
//  Created by askstory on 2017. 10. 19..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "VideoManager.h"
#import <AVKit/AVKit.h>

@implementation VideoManager

+(VideoManager *)sharedManager {
    static VideoManager *sharedInstance = nil;
    if (nil == sharedInstance) {
        @synchronized(self) {
            if (nil == sharedInstance) {
                sharedInstance = [[VideoManager alloc] init];
            }
        }
    }
    
    return sharedInstance;
}

-(id)init {
    if (self = [super init]) {
        NSArray *names = @[@"v1", @"v2", @"v3", @"v4", @"v5"];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (NSString *name in names) {
            NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"mp4"];
            NSURL *url = [NSURL fileURLWithPath:path];
            AVAsset *asset = [AVAsset assetWithURL:url];
            AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset:asset];
            AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:item];
            [tempArray addObject:player];
        }
        
        _array_Player = [[NSArray alloc] initWithArray:tempArray];
    }
    
    return self;
}

@end
