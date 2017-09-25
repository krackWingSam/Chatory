//
//  Chat_AnswerReactionViewController.h
//  Chatory
//
//  Created by askstory on 2017. 9. 25..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Chat_AnswerReactionViewControllerDelegate

-(void)changedViewHeight;

@end


@interface Chat_AnswerReactionViewController : UIViewController

@property NSString *string_RightAnswer;
@property NSString *string_WrongAnswer;
@property Teacher *teacher;

@property id <Chat_AnswerReactionViewControllerDelegate> delegate;

@end
