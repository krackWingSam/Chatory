//
//  CTSpeechRecognizer.h
//  Chatory
//
//  Created by askstory on 2017. 9. 26..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CTSpeechRecognizerDelegate

-(void)speechedText:(NSString *)string;

@end


@interface CTSpeechRecognizer : NSObject

+(CTSpeechRecognizer *)sharedRecognizer;

-(void)start;
-(void)stop;

@property id <CTSpeechRecognizerDelegate> delegate;

@end
