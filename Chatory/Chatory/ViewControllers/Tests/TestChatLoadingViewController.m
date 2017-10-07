//
//  TestChatLoadingViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 27..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "TestChatLoadingViewController.h"
#import "Chat_LoadingViewController.h"

@interface TestChatLoadingViewController () {
    Chat_LoadingViewController *loadingVC;
    Chat_LoadingViewController *moveLoadingVC;
    
    Content *_content;
}

@end

@implementation TestChatLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    _content = [ContentManager getContentWithContentKey:CONTENT_KEY_01 withTeacherKey:TEACHER_KEY_TIGER];
    loadingVC = [[Chat_LoadingViewController alloc] initWithNibName:@"Chat_LoadingViewController" bundle:nil];
    [loadingVC setTeacher:_content.teacher];
    
    [loadingVC.view setFrame:CGRectMake(0, 100, loadingVC.view.frame.size.width, loadingVC.view.frame.size.height)];
    [self.view addSubview:loadingVC.view];
    
    moveLoadingVC = [[Chat_LoadingViewController alloc] initWithNibName:@"Chat_LoadingViewController" bundle:nil];
    [moveLoadingVC setTeacher:_content.teacher];
    
    [self performSelector:@selector(animation) withObject:nil afterDelay:1.f];
}


#pragma mark - Animations
-(void)animation {
    CGRect frame = [[UIScreen mainScreen] bounds];
    UIView *view = moveLoadingVC.view;
    [view removeFromSuperview];
    
    [view setFrame:CGRectMake(-frame.size.width/2, 300, view.frame.size.width, view.frame.size.height)];
    [self.view addSubview:view];
    [UIView animateWithDuration:0.4f animations:^{
        [view setFrame:CGRectMake(30, 300, view.frame.size.width, view.frame.size.height)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2f animations:^{
            [view setFrame:CGRectMake(0, 300, view.frame.size.width, view.frame.size.height)];
        }];
    }];
}


#pragma mark - IBActions
-(IBAction)action_Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
