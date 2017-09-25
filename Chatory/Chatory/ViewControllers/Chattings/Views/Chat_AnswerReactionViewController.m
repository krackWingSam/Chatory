//
//  Chat_AnswerReactionViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 25..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "Chat_AnswerReactionViewController.h"

@interface Chat_AnswerReactionViewController () {
    IBOutlet UIView *view_Reaction;
    IBOutlet UIImageView *imageView_Icon;
    IBOutlet UIImageView *imageView_Emotion;
    IBOutlet UIImageView *imageView_Reaction;
}

@end

@implementation Chat_AnswerReactionViewController

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
    CGRect frame = [[UIScreen mainScreen] bounds];
    CGFloat viewHeight =  imageView_Reaction.frame.origin.y + imageView_Reaction.frame.size.height;
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, frame.size.width, viewHeight)];
    
    [self.view addSubview:view_Reaction];
    
    if (_string_RightAnswer) {
        [imageView_Reaction setAnimatedGif:_teacher.currectImage];
        [imageView_Reaction startGifAnimation];
    }
}

@end
