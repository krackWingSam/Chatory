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
    [loadingVC setQuestion:[[_content array_Question] objectAtIndex:0]];
    
    [loadingVC.view setFrame:CGRectMake(0, 100, loadingVC.view.frame.size.width, loadingVC.view.frame.size.height)];
    [self.view addSubview:loadingVC.view];
}


#pragma mark - IBActions
-(IBAction)action_Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
