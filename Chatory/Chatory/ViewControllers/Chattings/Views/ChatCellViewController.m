//
//  ChatCellViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 28..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "ChatCellViewController.h"

@interface ChatCellViewController () <Chat_LoadingViewControllerDelegate>

@end

@implementation ChatCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self initUI];
    [self showLoading];
}

-(void)initUI {
    currentIndex = 0;
    CGRect frame = [[UIScreen mainScreen] bounds];
    position_Loading = CGPointMake(-frame.size.width, 0);
    
    loadingVC = [[Chat_LoadingViewController alloc] initWithNibName:@"Chat_LoadingViewController" bundle:nil];
    [loadingVC setTeacher:_question.teacher];
    [loadingVC setDelegate:self];
    view_Loading = loadingVC.view;
}


#pragma mark - Animations
-(void)showLoading {
    dispatch_async(dispatch_get_main_queue(), ^{
        [view_Loading setFrame:CGRectMake(position_Loading.x, position_Loading.y, self.view.frame.size.width, view_Loading.frame.size.height)];
        [view_Loading setAlpha:0.f];
        [self.view addSubview:view_Loading];
        [loadingVC showDotAnimation];
        
        [UIView animateWithDuration:0.4f animations:^{
            CGRect frame = [view_Loading frame];
            frame.origin.x = 30;
            [view_Loading setAlpha:1.f];
            [view_Loading setFrame:frame];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2f animations:^{
                CGRect frame = [view_Loading frame];
                frame.origin.x = 0;
                [view_Loading setFrame:frame];
            }];
        }];
    });
}

-(void)showNextView {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (currentIndex == [array_Views count])
            return;
        UIView *currentView = [array_Views objectAtIndex:currentIndex];
        CGFloat yPosition = 0;
        
        if (currentIndex != 0) {
            UIView *beforeView = nil;
            beforeView = [array_Views objectAtIndex:currentIndex - 1];
            yPosition = beforeView.frame.origin.y + beforeView.frame.size.height;
        }
        
        [currentView setFrame:CGRectMake(0, yPosition, currentView.frame.size.width, currentView.frame.size.height)];
        [currentView setAlpha:0.f];
        [self.view addSubview:currentView];
        
        [UIView animateWithDuration:0.4f animations:^{
            [view_Loading setAlpha:0.f];
            [currentView setAlpha:1.f];
            [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, currentView.frame.origin.y + currentView.frame.size.height)];
        } completion:^(BOOL finished) {
            currentIndex += 1;
            position_Loading.y = currentView.frame.origin.y + currentView.frame.size.height;
            if (currentIndex < [array_Views count]) {
                [loadingVC setShowIcon:NO];
                [self showLoading];
            }
            else {
                if (self.delegate) {
                    [self.delegate showViewsDone];
                    if (_string_RightAnswer)
                        [self.delegate loadNextQuestion];
                }
            }
        }];
    });
}


#pragma mark - Chat_LoadingViewControllerDelegate
-(void)doneLoadingAnimation {
    if (currentIndex != [array_Views count])
        [self showNextView];
}


@end
