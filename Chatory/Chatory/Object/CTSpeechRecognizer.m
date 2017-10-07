//
//  CTSpeechRecognizer.m
//  Chatory
//
//  Created by askstory on 2017. 9. 26..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "CTSpeechRecognizer.h"

#import <AVKit/AVKit.h>
#import <Speech/Speech.h>

@interface CTSpeechRecognizer () <SFSpeechRecognitionTaskDelegate> {
    AVAudioEngine *engine;
    SFSpeechRecognizer *speechRecognizer;
    SFSpeechAudioBufferRecognitionRequest *request;
    SFSpeechRecognitionTask *task;
}

@end


@implementation CTSpeechRecognizer

+(CTSpeechRecognizer *)sharedRecognizer {
    static CTSpeechRecognizer *sharedInstance = nil;
    if (nil == sharedInstance) {
        @synchronized(self) {
            if (nil == sharedInstance) {
                sharedInstance = [[CTSpeechRecognizer alloc] init];
            }
        }
    }
    
    return sharedInstance;
}


-(id)init {
    if (self = [super init]) {
        
    }
    return self;
}

-(void)initSTT {
    engine = [[AVAudioEngine alloc] init];
    speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:[NSLocale localeWithLocaleIdentifier:@"en-UR"]];
    request = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    
    AVAudioInputNode *node =  [engine inputNode];
    AVAudioFormat *format = [node outputFormatForBus:0];
    [node installTapOnBus:0 bufferSize:1024 format:format block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [request appendAudioPCMBuffer:buffer];
    }];
    
    [engine prepare];
}


#pragma mark - public
-(void)start {
    [self initSTT];
    
    if (task || speechRecognizer.isAvailable == NO)
        return;
    
    NSError *error = nil;
    
    [engine startAndReturnError:&error];
    
    task = [speechRecognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        NSLog(@"append buffer : ");
        if (error) {
            NSLog(@"STT error : %@", error);
            return;
        }
        NSString *bestString = [result.bestTranscription formattedString];
        
        if (_delegate)
            [self.delegate speechedText:bestString];
    }];
    
}

-(void)stop {
    [task finish];
    task = nil;
    
    [engine stop];
}


@end
