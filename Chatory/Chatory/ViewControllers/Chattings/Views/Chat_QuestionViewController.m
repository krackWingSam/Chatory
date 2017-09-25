//
//  Chat_QuestionViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 22..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "Chat_QuestionViewController.h"

@interface Chat_QuestionViewController () {
    IBOutlet UIView *view_Loading;
    IBOutlet UIView *view_Question_01_01a;
    IBOutlet UIView *view_Question_01_01b;
    
    NSArray *array_Views;
    int currentIndex;
}

@end

@implementation Chat_QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initUI];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self showLoading];
}

-(void)initUI {
    if ([_question.key isEqualToString:QUESTION_KEY_01]) {
        CGRect frame = [[UIScreen mainScreen] bounds];
        [view_Loading setFrame:CGRectMake(0, 0, frame.size.width, view_Loading.frame.size.height)];
        [view_Question_01_01a setFrame:CGRectMake(0, 0, frame.size.width, view_Question_01_01a.frame.size.height)];
        [view_Question_01_01b setFrame:CGRectMake(0, 0, frame.size.width, view_Question_01_01b.frame.size.height)];
        array_Views = @[view_Question_01_01a, view_Question_01_01b];
    }
}


#pragma mark - Animations
-(void)showLoading {
    dispatch_async(dispatch_get_main_queue(), ^{
        [view_Loading setAlpha:0.f];
        [view_Loading setFrame:CGRectMake(self.view.frame.size.width/2, 0, view_Loading.frame.size.width, view_Loading.frame.size.height)];
        [self.view addSubview:view_Loading];
        
        [UIView animateWithDuration:AnimationDuration animations:^{
            CGRect frame = [view_Loading frame];
            frame.origin.x = 0;
            
            [view_Loading setFrame:frame];
            [view_Loading setAlpha:1.f];
        } completion:^(BOOL finished) {
            currentIndex = 0;
            [self showFirstView];
        }];
    });
}

-(void)showFirstView {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *currentView = [array_Views objectAtIndex:0];
        [currentView setAlpha:0.f];
        [self.view addSubview:currentView];
        [UIView animateWithDuration:AnimationDuration animations:^{
            [currentView setAlpha:1.f];
        } completion:^(BOOL finished) {
            [view_Loading removeFromSuperview];
            currentIndex++;
            [self showViewWithIndex:currentIndex];
        }];
    });
}

-(void)showViewWithIndex:(int)index {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *currentView = [array_Views objectAtIndex:index];
        UIView *beforeView = [array_Views objectAtIndex:index-1];
        CGRect frame = [currentView frame];
        
        frame.origin.y = beforeView.frame.origin.y + beforeView.frame.size.height;
        [currentView setFrame:frame];
        
        [currentView setAlpha:0.f];
        
        [self.view addSubview:currentView];
        
        [UIView animateWithDuration:AnimationDuration animations:^{
            [currentView setAlpha:1.f];
            CGRect frame = [self.view frame];
            
            frame.size.height = currentView.frame.origin.y + currentView.frame.size.height;
            [self.view setFrame:frame];
            
        } completion:^(BOOL finished) {
            currentIndex += 1;
            if (currentIndex == [array_Views count])
                [self.delegate showViewsDone];
            else
                [self showViewWithIndex:currentIndex];
        }];
    });
}

@end
