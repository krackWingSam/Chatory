//
//  ChattingViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 20..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "ChattingViewController.h"
#import "Chat_QuestionViewController.h"
#import "Chat_AnswerSheetViewController.h"
#import "UserAnswerViewController.h"
#import "Chat_AnswerReactionViewController.h"

@interface ChattingViewController () <Chat_QuestionViewControllerDelegate, Chat_AnswerSheetViewControllerDelegate, Chat_AnswerReactionViewControllerDelegate> {
    IBOutlet UIScrollView *scroll_Chat;
    
    IBOutlet NSLayoutConstraint *constraint_ScrollBottom;
    
    UIViewController *currentAnswerSheetVC;
    NSMutableArray *array_Chat;
    int questionIndex;
}

@end

@implementation ChattingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    array_Chat = [[NSMutableArray alloc] init];
    
    _content = [ContentManager getContentWithContentKey:CONTENT_KEY_01 withTeacherKey:TEACHER_KEY_TIGER];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self registNotification];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self removeNotification];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self loadNextQuestion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Notifications
-(void)registNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
}

-(void)willShowKeyboard:(NSNotification *)noti {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        CGRect frame = [[UIScreen mainScreen] bounds];
        CGRect keyboardFrame = [(NSValue *)[noti.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
        CGFloat animationDuration = [[noti.userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    
        frame.size.height -= keyboardFrame.size.height;
    
        [UIView animateWithDuration:animationDuration animations:^{
            [mainWindow setFrame:frame];
        }];
    });
}


#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)_textField {
    [_textField resignFirstResponder];
    return YES;
}



#pragma mark - ScrollView Content
-(void)reloadScrollView {
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat lastYPosition = 0.f;
        CGRect frame = [[UIScreen mainScreen] bounds];
        for (int i=0 ; i<[array_Chat count] ; i++) {
            UIViewController *vc = [array_Chat objectAtIndex:i];
            
            if (i == 0)
                lastYPosition = 20;
            
            
            CGRect frame = [vc.view frame];
            frame.origin.y = lastYPosition;
            [vc.view setFrame:frame];
            [scroll_Chat addSubview:vc.view];
            
            lastYPosition += vc.view.frame.size.height;
        }
        
        [scroll_Chat setContentSize:CGSizeMake(frame.size.width, lastYPosition)];
        
        if (lastYPosition > scroll_Chat.frame.size.height) {
            [UIView animateWithDuration:AnimationDuration animations:^{
                [scroll_Chat setContentOffset:CGPointMake(0, lastYPosition - scroll_Chat.frame.size.height)];
            }];
        }
    });
}


#pragma mark - Load VC
-(void)loadNextQuestion {
    if (_content.currentQuestion == nil) {
        Question *currentQuestion = [_content.array_Question objectAtIndex:0];
        [_content setCurrentQuestion:currentQuestion];
        
        [array_Chat addObject:currentQuestion.questionViewController];
        questionIndex = 0;
    }
    else {
        questionIndex += 1;
        Question *currentQuestion = [_content.array_Question objectAtIndex:questionIndex];
        [_content setCurrentQuestion:currentQuestion];
        
        [array_Chat addObject:currentQuestion.questionViewController];
    }
    
    [(Chat_QuestionViewController *)_content.currentQuestion.questionViewController setDelegate:self];
    
    [self reloadScrollView];
}



#pragma mark - IBActions
-(IBAction)action_Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)action_TextField:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *currentQuestionVC = _content.currentQuestion.questionViewController;
        CGFloat yPosition = [currentQuestionVC.view frame].origin.y;
        
        [self.view addSubview:currentAnswerSheetVC.view];
        [currentAnswerSheetVC.view setAlpha:0.f];
        
        [UIView animateWithDuration:AnimationDuration animations:^{
            [scroll_Chat setContentOffset:CGPointMake(0, yPosition - 40)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:AnimationDuration animations:^{
                [currentAnswerSheetVC.view setAlpha:1.f];
            }];
        }];
    });
}


#pragma mark - Chat_QuestionViewControllerDelegate
-(void)showViewsDone {
    UIViewController *currentAnswerVC = _content.currentQuestion.answerViewController;
    currentAnswerSheetVC = currentAnswerVC;
    
    if ([currentAnswerVC class] == [Chat_AnswerSheetViewController class]) {
        [(Chat_AnswerSheetViewController *)currentAnswerVC setDelegate:self];
        
        [currentAnswerVC.view setAlpha:0.f];
        [self.view addSubview:currentAnswerVC.view];
        
        [constraint_ScrollBottom setConstant:currentAnswerVC.view.frame.size.height - 57];
        [UIView animateWithDuration:AnimationDuration animations:^{
            [currentAnswerVC.view setAlpha:1.f];
        }];
    }
    
    [self reloadScrollView];
}


#pragma mark - Chat_AnswerSheetViewControllerDelegate
-(void)isRightAnswer:(NSString *)string_Answer {
    dispatch_async(dispatch_get_main_queue(), ^{
        [constraint_ScrollBottom setConstant:0.f];
        [UIView animateWithDuration:AnimationDuration animations:^{
            [currentAnswerSheetVC.view setAlpha:0.f];
        } completion:^(BOOL finished) {
            [currentAnswerSheetVC.view removeFromSuperview];
        }];
        
        UserAnswerViewController *answerVC = [[UserAnswerViewController alloc] initWithNibName:@"UserAnswerViewController" bundle:nil];
        [answerVC setString_Answer:string_Answer];
        
        [array_Chat addObject:answerVC];
        
        [self reloadScrollView];
        
        Chat_AnswerReactionViewController *vc = [[Chat_AnswerReactionViewController alloc] initWithNibName:@"Chat_AnswerReactionViewController" bundle:nil];
        [vc setDelegate:self];
        [vc setTeacher:_content.teacher];
        
        if ([_content.currentQuestion isAnswer:string_Answer]) {
            [vc setString_RightAnswer:string_Answer];
        }
        else {
            [vc setString_WrongAnswer:string_Answer];
        }
        
        [array_Chat addObject:vc];
        
        [self reloadScrollView];
    });
}


#pragma mark - Chat_AnswerReactionViewControllerDelegate
-(void)changedViewHeight {
    [self reloadScrollView];
}


@end
