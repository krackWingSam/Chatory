//
//  UserAnswerViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 25..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "UserAnswerViewController.h"

@interface UserAnswerViewController () {
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *label_Answer;
}

@end

@implementation UserAnswerViewController

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

-(void)initUI {
    UIImage *image;
    
    image = [UIImage imageNamed:@"null_bubble"];
    [label_Answer setText:_string_Answer];
    
    [imageView setImage:image];
}


@end
