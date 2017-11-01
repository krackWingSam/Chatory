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
    
    [self initUI];
    [self initImages];
    [self initActions];
    
    [self setThumbImage:[array_Image objectAtIndex:0] forState:UIControlStateNormal];
}

-(void)initUI {
    view_TintBack = [UIView new];
    [view_TintBack setBackgroundColor:RGBA(216, 216, 216, 1)];
    CGRect frame = [self bounds];
    frame.size.height = self.frame.size.height / 6;
    [view_TintBack setFrame:frame];
    
    view_Tint = [UIView new];
    frame.size.height = self.bounds.size.height / 6;
    [view_Tint setFrame:frame];
    [view_Tint setBackgroundColor:RGBA(87, 163, 255, 1)];
    
    [self insertSubview:view_Tint atIndex:0];
    [self insertSubview:view_TintBack atIndex:0];
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
}

-(void)setValue:(float)value {
    [super setValue:value];
    
    [self action_ValueChange:self];
}


#pragma mark - for Actions
-(void)action_ValueChange:(id)sender {
//    dispatch_async(dispatch_get_main_queue(), ^{
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
    
        CGRect frame = [view_Tint bounds];
        frame.size.width = self.frame.size.width / 5 * value;
        [view_Tint setFrame:frame];
//    });
    
}

@end
