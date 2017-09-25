//
//  Chat_AnswerSheetViewController.h
//  Chatory
//
//  Created by askstory on 2017. 9. 25..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Chat_AnswerSheetViewControllerDelegate

-(void)isRightAnswer:(NSString *)string_Answer;

@end


@interface Chat_AnswerSheetViewController : UIViewController

@property Question *question;
@property id <Chat_AnswerSheetViewControllerDelegate> delegate;

@end
