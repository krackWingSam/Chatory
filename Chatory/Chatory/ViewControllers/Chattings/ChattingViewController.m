//
//  ChattingViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 20..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "ChattingViewController.h"

@interface ChattingViewController ()

@end

@implementation ChattingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties
-(void)setContentDic:(NSDictionary *)contentDic {
    _contentDic = contentDic;
    //TODO: set contents for character, questions, answers or etc
}

@end
