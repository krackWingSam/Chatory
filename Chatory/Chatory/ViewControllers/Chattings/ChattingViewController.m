//
//  ChattingViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 20..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "ChattingViewController.h"

@interface ChattingViewController () <UITextFieldDelegate> {
    IBOutlet UIScrollView *scroll_Chat;
    IBOutlet UITextField *textField;
    
    NSMutableArray *array_Chat;
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


#pragma mark - Load VC
-(void)loadNextQuestion {
    if (_content.currentQuestion == nil) {
        Question *currentQuestion = [_content.array_Question objectAtIndex:0];
        [_content setCurrentQuestion:currentQuestion];
        
        
    }
}



#pragma mark - IBActions
-(IBAction)action_Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




@end
