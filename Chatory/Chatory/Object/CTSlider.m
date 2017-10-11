//
//  CTSlider.m
//  Chatory
//
//  Created by askstory on 2017. 10. 10..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "CTSlider.h"

@interface CTSlider () {
    NSArray *array_Image;
    UIView *view_TintBack;
    UIView *view_Tint;
}

@end

@implementation CTSlider
-(void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"awake from nib file");
    
    [self initImages];
    [self initActions];
    
    [self setThumbImage:[array_Image objectAtIndex:0] forState:UIControlStateNormal];
}

-(void)initImages {
    NSArray *names = @[@"#01_icon", @"#02_icon", @"#03_icon", @"#04_icon", @"#05_icon"];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (NSString *name in names) {
        UIImage *image = [UIImage imageNamed:name];
        [tempArray addObject:image];
    }
    
    array_Image = [[NSArray alloc] initWithArray:tempArray];
    
    [self setMaximumTrackTintColor:[UIColor clearColor]];
    [self setMinimumTrackTintColor:[UIColor clearColor]];
}

-(void)initActions {
    [self addTarget:self action:@selector(action_ValueChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 그림을 그린다.
    UIBezierPath *baackgroundPath = [UIBezierPath bezierPath];
    [baackgroundPath setLineWidth:self.frame.size.height/3 * 2];
    [baackgroundPath moveToPoint:CGPointMake(0, 0)];
    [baackgroundPath addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    UIColor *backgroundColor = RGBA(216, 216, 216, 1);
    [backgroundColor setFill];
    [backgroundColor setStroke];
    
    [baackgroundPath stroke];
    [baackgroundPath fill];
    
    UIBezierPath *fillPath = [UIBezierPath bezierPath];
}


#pragma mark - for Actions
-(void)action_ValueChange:(id)sender {
    [self drawRect:self.bounds];
    
    CGFloat value = self.value;
    NSInteger index = 0;
    if (value > 0 && value < 1.5)
        index = 0;
    else if (value >= 1.5 && value < 2.5)
        index = 1;
    else if (value >= 2.5 && value < 3.5)
        index = 2;
    else if (value >= 3.5 && value < 4.5)
        index = 3;
    else
        index = 4;
    
    [self setThumbImage:[array_Image objectAtIndex:index] forState:UIControlStateNormal];
}

@end
