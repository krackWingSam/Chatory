//
//  SelectTeacherViewController.m
//  Chatory
//
//  Created by askstory on 2017. 10. 7..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "SelectTeacherViewController.h"

@interface SelectTeacherViewController () <UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIView *contentView;
    
    IBOutlet UIImageView *image_Teacher01;
    IBOutlet UIImageView *image_Teacher02;
    IBOutlet UIImageView *image_Teacher03;
    
    AnimatedGif *gif01;
    AnimatedGif *gif02;
    AnimatedGif *gif03;
}

@end

@implementation SelectTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        NSString *path = [[NSBundle mainBundle] pathForResource:@"character_01" ofType:@"gif"];
        NSData *tempData = [[NSData alloc] initWithContentsOfFile:path];
        gif01 = [AnimatedGif getAnimationForGifWithData:tempData];
        [image_Teacher01 setAnimatedGif:gif01];
        
        path = [[NSBundle mainBundle] pathForResource:@"character_02" ofType:@"gif"];
        tempData = [[NSData alloc] initWithContentsOfFile:path];
        gif02 = [AnimatedGif getAnimationForGifWithData:tempData];
        [image_Teacher02 setAnimatedGif:gif02];
        
        path = [[NSBundle mainBundle] pathForResource:@"character_03" ofType:@"gif"];
        tempData = [[NSData alloc] initWithContentsOfFile:path];
        gif03 = [AnimatedGif getAnimationForGifWithData:tempData];
        [image_Teacher03 setAnimatedGif:gif03];
        
        [image_Teacher01 startGifAnimation];
        [image_Teacher02 startGifAnimation];
        [image_Teacher03 startGifAnimation];
    });
    
    [scrollView addSubview:contentView];
    [scrollView setContentSize:contentView.frame.size];
    [scrollView setDelegate:self];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)_scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat targetX = scrollView.contentOffset.x + velocity.x * 60.0;
    CGFloat indexWidth = contentView.frame.size.width / 3;
    CGFloat indexMargin = indexWidth / 2;
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        [image_Teacher01 stopAnimating];
//        [image_Teacher02 stopAnimating];
//        [image_Teacher03 stopAnimating];
    });
    
    if (targetX < indexWidth - indexMargin) {
        targetContentOffset->x = 0;
        dispatch_async(dispatch_get_main_queue(), ^{
//            [image_Teacher01 startAnimating];
        });
    }
    else if (targetX > indexWidth * 2 - indexMargin) {
        targetContentOffset->x = indexWidth * 2;
        dispatch_async(dispatch_get_main_queue(), ^{
//            [image_Teacher03 startAnimating];
        });
    }
    else {
        targetContentOffset->x = 294-43;
        dispatch_async(dispatch_get_main_queue(), ^{
//            [image_Teacher02 startAnimating];
        });
    }
}



@end
