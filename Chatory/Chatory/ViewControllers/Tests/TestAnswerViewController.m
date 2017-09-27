//
//  TestAnswerViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 27..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "TestAnswerViewController.h"
#import "Chat_AnswerSheetViewController.h"

@interface TestAnswerViewController () {
    IBOutlet UITextField *tf_Answer;
    IBOutlet UIButton *button_Send;
    IBOutlet UIView *view_AnswerRect;
    
    Content *_content;
    
    UIViewController *currentAnswerVC;
    BOOL isShowAnswerSheet;
}

@end

@implementation TestAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    isShowAnswerSheet = NO;
    _content = [ContentManager getContentWithContentKey:CONTENT_KEY_01 withTeacherKey:TEACHER_KEY_TIGER];
    [button_Send setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Animations
-(void)animationShowAnswerSheet {
    if (isShowAnswerSheet == YES)
        return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        isShowAnswerSheet = YES;
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        UIView *view_Answer = currentAnswerVC.view;
        [view_Answer setFrame:CGRectMake(0, frame.size.height, view_Answer.frame.size.width, view_Answer.frame.size.height)];
        [self.view insertSubview:view_Answer belowSubview:view_AnswerRect];
        [UIView animateWithDuration:0.5f animations:^{
            [view_Answer setFrame:CGRectMake(0, frame.size.height - view_Answer.frame.size.height, view_Answer.frame.size.width, view_Answer.frame.size.height)];
        }];
    });
}

-(void)animationHideAnswerSheet {
    if (isShowAnswerSheet == NO)
        return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5f animations:^{
            CGRect frame = [[UIScreen mainScreen] bounds];
            UIView *view_Answer = currentAnswerVC.view;
            [view_Answer setFrame:CGRectMake(0, frame.size.height, view_Answer.frame.size.width, view_Answer.frame.size.height)];
        } completion:^(BOOL finished) {
            [currentAnswerVC.view removeFromSuperview];
        }];
        
        isShowAnswerSheet = NO;
    });
}


#pragma mark - IBActions
-(IBAction)action_Back:(id)sender {
    [self animationHideAnswerSheet];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)action_BackgroundTouch:(id)sender {
    [self animationHideAnswerSheet];
}

-(IBAction)action_SegmentedControl:(UISegmentedControl *)sender {
    [self animationHideAnswerSheet];
    NSInteger currentIndex = [sender selectedSegmentIndex];
    if (currentIndex < [_content.array_Question count]) {
        [_content setCurrentQuestion:[[_content array_Question] objectAtIndex:currentIndex]];
    }
    else {
        [_content setCurrentQuestion:nil];
    }
        
}

-(IBAction)action_TapTextField:(id)sender {
    currentAnswerVC = _content.currentQuestion.answerViewController;
    
    [self animationShowAnswerSheet];
}


@end
