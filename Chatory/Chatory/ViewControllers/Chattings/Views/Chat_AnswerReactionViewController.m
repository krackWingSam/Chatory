//
//  Chat_AnswerReactionViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 25..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "Chat_AnswerReactionViewController.h"

@interface Chat_AnswerReactionViewController () {
    IBOutlet UIView *view_Emotion;
    IBOutlet UIView *view_Reaction;
    IBOutlet UIView *view_Wrong;
    IBOutlet UIImageView *imageView_Icon;
    IBOutlet UIImageView *imageView_Emotion;
    IBOutlet UIImageView *imageView_Reaction;
    IBOutlet UIImageView *imageView_WrongGIF;
    
    NSArray *array_Wrongimages;
    NSInteger currentWrongImageIndex;
}

@end

@implementation Chat_AnswerReactionViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (currentWrongImageIndex < 0)
        return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [imageView_WrongGIF setAnimatedGif:[array_Wrongimages objectAtIndex:currentWrongImageIndex]];
        [imageView_WrongGIF startGifAnimation];
    });
}

-(void)initUI {
    [super initUI];
    [self initImages];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    [imageView_Emotion setAnimationRepeatCount:1];
    
    [imageView_Icon setImage:self.question.teacher.icon];
    
    array_Views = @[view_Emotion, view_Reaction];
    currentWrongImageIndex = -1;
    
    if (self.string_RightAnswer) {
        [imageView_Emotion setAnimatedGif:[self.question.teacher getRightImage]];
        [imageView_Emotion startGifAnimation];
        
        if ([self.string_RightAnswer isEqualToString:@"hop"]) {
            [imageView_Reaction setImage:[UIImage imageNamed:@"Q01_correct_text01"]];
        }
        if ([self.string_RightAnswer isEqualToString:@"Forest"]) {
            [imageView_Reaction setImage:[UIImage imageNamed:@"Q02_correct_text01"]];
        }
        if ([self.string_RightAnswer isEqualToString:@"Race"] || [self.string_RightAnswer isEqualToString:@"race"]) {
            [imageView_Reaction setImage:[UIImage imageNamed:@"Q03_correct_text01"]];
        }
    }
    else {
        [imageView_Emotion setAnimatedGif:[self.question.teacher getWrongImage]];
        [imageView_Emotion startGifAnimation];
        
        if ([self.string_WrongAnswer isEqualToString:@"crawl"]) {
            [imageView_Reaction setImage:[UIImage imageNamed:@"Q01_wrong01_text"]];
            array_Views = @[view_Emotion, view_Reaction, view_Wrong];
            currentWrongImageIndex = 0;
        }
        else if ([self.string_WrongAnswer isEqualToString:@"waddle"]) {
            [imageView_Reaction setImage:[UIImage imageNamed:@"Q01_wrong02_text"]];
            array_Views = @[view_Emotion, view_Reaction, view_Wrong];
            currentWrongImageIndex = 1;
        }
        else if ([self.string_WrongAnswer isEqualToString:@"flap"]) {
            [imageView_Reaction setImage:[UIImage imageNamed:@"Q01_wrong03_text"]];
            array_Views = @[view_Emotion, view_Reaction, view_Wrong];
            currentWrongImageIndex = 2;
        }
        else {
            [imageView_Reaction setImage:[UIImage imageNamed:@"Q02_wrong01_text"]];
        }
    }
    
    [view_Emotion setFrame:CGRectMake(0, 0, frame.size.width, view_Emotion.frame.size.height)];
    [view_Reaction setFrame:CGRectMake(0, view_Emotion.frame.origin.y + view_Emotion.frame.size.height, frame.size.width, imageView_Reaction.image.size.height + 10)];
}

-(void)initImages {
    NSArray *names = @[@"Q01_wrong_clunk", @"Q01_wrong_waddle", @"Q01_wrong_flap"];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSString *name in names) {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        NSData *tempData = [[NSData alloc] initWithContentsOfFile:path];
        AnimatedGif *tempGif = [AnimatedGif getAnimationForGifWithData:tempData];
        
        [tempArray addObject:tempGif];
    }
    
    array_Wrongimages = [[NSArray alloc] initWithArray:tempArray];
}


@end
