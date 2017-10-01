//
//  ChatCellViewController.h
//  Chatory
//
//  Created by askstory on 2017. 9. 28..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Chat_LoadingViewController.h"



@protocol ChatCellDelegate

-(void)showViewsDone;
-(void)loadNextQuestion;

@end

@interface ChatCellViewController : UIViewController {
    Chat_LoadingViewController *loadingVC;
    UIView *view_Loading;
    CGPoint position_Loading;
    NSArray *array_Views;
    int currentIndex;
}

-(void)initUI;
-(void)calcFrames;

#pragma mark - Animations
-(void)showLoading;
-(void)showNextView;

#pragma mark - properties
@property Question *question;

//Answer Reaction
@property NSString *string_RightAnswer;
@property NSString *string_WrongAnswer;

@property id <ChatCellDelegate> delegate;

@end
