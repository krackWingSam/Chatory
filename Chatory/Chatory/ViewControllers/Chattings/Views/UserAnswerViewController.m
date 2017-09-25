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
    if ([_string_Answer isEqualToString:@"hop"])
        image = [UIImage imageNamed:@"Q01_correct_answer"];
    if ([_string_Answer isEqualToString:@"crawl"])
        image = [UIImage imageNamed:@"Q01_wrong01_answer"];
    if ([_string_Answer isEqualToString:@"waddle"])
        image = [UIImage imageNamed:@"Q01_wrong02_answer"];
    if ([_string_Answer isEqualToString:@"flap"])
        image = [UIImage imageNamed:@"Q01_wrong03_answer"];
    
    [imageView setImage:image];
}


@end
