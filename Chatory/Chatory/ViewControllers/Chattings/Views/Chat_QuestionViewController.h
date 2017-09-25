//
//  Chat_QuestionViewController.h
//  Chatory
//
//  Created by askstory on 2017. 9. 22..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol Chat_QuestionViewControllerDelegate

-(void)showViewsDone;

@end


@interface Chat_QuestionViewController : UIViewController

@property Question *question;
@property id <Chat_QuestionViewControllerDelegate> delegate;

@end
