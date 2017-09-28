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

@interface ChattingViewController () <ChatCellDelegate, Chat_AnswerSheetViewControllerDelegate> {
    IBOutlet UIScrollView *scroll_Chat;
    IBOutlet UIView *view_TFBackground;
    IBOutlet UITextField *tf_Answer;
    IBOutlet UIButton *button_TextField;
    IBOutlet UIButton *button_Send;
    
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
    [button_Send setHidden:YES];
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
        
        if (lastYPosition > scroll_Chat.frame.size.height) {
            [UIView animateWithDuration:AnimationDuration animations:^{
                [scroll_Chat setContentSize:CGSizeMake(frame.size.width, lastYPosition + currentAnswerSheetVC.view.frame.size.height - view_TFBackground.frame.size.height)];
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

-(void)showAnswerSheet {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (currentAnswerSheetVC == nil)
            return;
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        [currentAnswerSheetVC.view setFrame:CGRectMake(0, frame.size.height, currentAnswerSheetVC.view.frame.size.width, currentAnswerSheetVC.view.frame.size.height)];
        [self.view insertSubview:currentAnswerSheetVC.view belowSubview:view_TFBackground];
        
        NSString *placeHolder = [(Chat_AnswerSheetViewController *)currentAnswerSheetVC placeHolder];
        [tf_Answer setPlaceholder:placeHolder];
        
        [UIView animateWithDuration:0.3f animations:^{
            [currentAnswerSheetVC.view setFrame:CGRectMake(0, frame.size.height - currentAnswerSheetVC.view.frame.size.height - 10, currentAnswerSheetVC.view.frame.size.width, currentAnswerSheetVC.view.frame.size.height)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2f animations:^{
                [currentAnswerSheetVC.view setFrame:CGRectMake(0, frame.size.height - currentAnswerSheetVC.view.frame.size.height, currentAnswerSheetVC.view.frame.size.width, currentAnswerSheetVC.view.frame.size.height)];
                
                if (scroll_Chat.contentSize.height > scroll_Chat.frame.size.height)
                    [scroll_Chat setContentOffset:CGPointMake(0, scroll_Chat.contentSize.height -(scroll_Chat.frame.size.height))];
            }];
        }];
    });
}

-(void)hideAnswerSheet {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (currentAnswerSheetVC == nil)
            return;
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        [UIView animateWithDuration:0.4f animations:^{
            [currentAnswerSheetVC.view setFrame:CGRectMake(0, frame.size.height, currentAnswerSheetVC.view.frame.size.width, currentAnswerSheetVC.view.frame.size.height)];
        } completion:^(BOOL finished) {
            [currentAnswerSheetVC.view removeFromSuperview];
            [tf_Answer setPlaceholder:@""];
        }];
    });
}



#pragma mark - IBActions
-(IBAction)action_Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)action_TextField:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        currentAnswerSheetVC = _content.currentQuestion.answerViewController;
        UIViewController *currentQuestionVC = _content.currentQuestion.questionViewController;
        CGFloat yPosition = [currentQuestionVC.view frame].origin.y - 20;
        
        [UIView animateWithDuration:0.2f animations:^{
            [scroll_Chat setContentOffset:CGPointMake(0, yPosition)];
        }];
        [self showAnswerSheet];
    });
}

-(IBAction)action_SendAnswer:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        UserAnswerViewController *answerVC = [[UserAnswerViewController alloc] initWithNibName:@"UserAnswerViewController" bundle:nil];
        [answerVC setString_Answer:tf_Answer.text];
        
        [array_Chat addObject:answerVC];
        
        Chat_AnswerReactionViewController *vc = [[Chat_AnswerReactionViewController alloc] initWithNibName:@"Chat_AnswerReactionViewController" bundle:nil];
        [vc setDelegate:self];
        [vc setQuestion:_content.currentQuestion];
        
        if ([_content.currentQuestion isAnswer:tf_Answer.text])
            [vc setString_RightAnswer:tf_Answer.text];
        else
            [vc setString_WrongAnswer:tf_Answer.text];
        
        [array_Chat addObject:vc];
        
        [self reloadScrollView];
        [self hideAnswerSheet];
        
        [tf_Answer setText:@""];
    });
}


#pragma mark - Chat_QuestionViewControllerDelegate
-(void)showViewsDone {
    UIViewController *currentAnswerVC = _content.currentQuestion.answerViewController;
    currentAnswerSheetVC = currentAnswerVC;
    
    if ([currentAnswerVC class] == [Chat_AnswerSheetViewController class]) {
        [(Chat_AnswerSheetViewController *)currentAnswerVC setDelegate:self];
        [self showAnswerSheet];
    }
    
    [self reloadScrollView];
}


#pragma mark - Chat_AnswerSheetViewControllerDelegate
-(void)selectAnswer:(NSString *)string_Answer {
    [tf_Answer setText:string_Answer];
    [button_Send setHidden:NO];
}


@end
