//
//  QuestionTableViewCell.m
//  Chatory
//
//  Created by askstory on 2017. 9. 20..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "QuestionTableViewCell.h"

@interface QuestionTableViewCell () {
    IBOutlet UIView *view_ImageTeacher;
    IBOutlet UIView *view_Question;
    IBOutlet UIView *view_Emoji;
}

@end


@implementation QuestionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self initUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)initUI {
    [view_ImageTeacher.layer setCornerRadius:view_ImageTeacher.frame.size.width/2];
    
    [view_Question.layer setCornerRadius:view_Question.frame.size.height/2];
    view_Question.layer.shadowColor = [UIColor blackColor].CGColor;
    view_Question.layer.shadowOffset = CGSizeMake(0, 4.0);
    view_Question.layer.shadowOpacity = 0.05;
    view_Question.layer.shadowRadius = 5.0;
    
    [view_Emoji.layer setCornerRadius:view_Question.frame.size.height/2];
    view_Emoji.layer.shadowColor = [UIColor blackColor].CGColor;
    view_Emoji.layer.shadowOffset = CGSizeMake(0, 4.0);
    view_Emoji.layer.shadowOpacity = 0.05;
    view_Emoji.layer.shadowRadius = 5.0;
}

@end
