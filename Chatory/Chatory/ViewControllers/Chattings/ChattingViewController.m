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

@interface ChattingViewController () <UITextFieldDelegate, Chat_QuestionViewControllerDelegate, Chat_AnswerSheetViewControllerDelegate> {
    IBOutlet UIScrollView *scroll_Chat;
    IBOutlet UITextField *textField;
    
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
    
    [textField resignFirstResponder];
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
            
            if ([vc class] == [Chat_QuestionViewController class]) {
                CGRect frame = [vc.view frame];
                frame.origin.y = lastYPosition;
                [vc.view setFrame:frame];
                [scroll_Chat addSubview:vc.view];
            }
            
            lastYPosition += vc.view.frame.size.height;
        }
        
        [scroll_Chat setContentSize:CGSizeMake(frame.size.width, lastYPosition)];
        
        if (lastYPosition > frame.size.height)
            [scroll_Chat setContentOffset:CGPointMake(0, lastYPosition - frame.size.height)];
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


#pragma mark - Chat_QuestionViewControllerDelegate
-(void)showViewsDone {
    UIViewController *currentAnswerVC = _content.currentQuestion.answerViewController;
    
    if ([currentAnswerVC class] == [Chat_AnswerSheetViewController class]) {
        [(Chat_AnswerSheetViewController *)currentAnswerVC setDelegate:self];
        
        [currentAnswerVC.view setAlpha:0.f];
        [self.view addSubview:currentAnswerVC.view];
        
        [UIView animateWithDuration:AnimationDuration animations:^{
            [currentAnswerVC.view setAlpha:1.f];
        }];
    }
}


#pragma mark - Chat_AnswerSheetViewControllerDelegate
-(void)selectAnswerViewController:(UIViewController *)userAnswerVC {
    
}

-(void)isRightAnswer:(NSString *)string_Answer {
    
}


@end
