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
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect frame = [[UIScreen mainScreen] bounds];
        [imageView_Emotion setAnimationRepeatCount:4];
        
        [self.view addSubview:view_Reaction];
        
        [imageView_Icon setImage:_teacher.icon];
        
        if (_string_RightAnswer) {
            [imageView_Emotion setAnimatedGif:_teacher.currectImage];
            [imageView_Emotion startGifAnimation];
            
            if ([_string_RightAnswer isEqualToString:@"hop"]) {
                [imageView_Reaction setImage:[UIImage imageNamed:@"Q01_correct_text01"]];
            }
        }
        else {
            [imageView_Emotion setAnimatedGif:[_teacher getWrongImage]];
            [imageView_Emotion startGifAnimation];
            
            if ([_string_WrongAnswer isEqualToString:@"crawl"]) {
                [imageView_Reaction setImage:[UIImage imageNamed:@"Q01_wrong01_text"]];
            }
            if ([_string_WrongAnswer isEqualToString:@"waddle"]) {
                [imageView_Reaction setImage:[UIImage imageNamed:@"Q01_wrong02_text"]];
            }
            if ([_string_WrongAnswer isEqualToString:@"flap"]) {
                [imageView_Reaction setImage:[UIImage imageNamed:@"Q01_wrong03_text"]];
            }
        }
        
        [view_Reaction setFrame:CGRectMake(0, 0, frame.size.width, imageView_Reaction.frame.origin.y +  imageView_Reaction.frame.size.height)];
        
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, view_Reaction.frame.size.width, view_Reaction.frame.size.height + 5)];
        
        [self performSelector:@selector(requestReload) withObject:nil afterDelay:0.25f];
    });
}

-(void)requestReload {
    [self.delegate changedViewHeight];
}

@end
