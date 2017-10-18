//
//  SelectFairyTaleViewController.m
//  Chatory
//
//  Created by askstory on 2017. 10. 7..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "SelectFairyTaleViewController.h"
#import "UserDataManager.h"

@interface SelectFairyTaleViewController () <UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIView *contentView;
    
    IBOutlet UIView *view_Animated;
    IBOutlet UIImageView *imageView_Background;
    
    IBOutlet UIImageView *imageView_TopBackground;
    IBOutlet UIImageView *imageView_Title;
    IBOutlet UIImageView *imageView_Line;
    IBOutlet UIImageView *imageView_Description;
    
    UserDataManager *manager;
}

@end

@implementation SelectFairyTaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI {
    manager = [UserDataManager sharedManager];
    
    [scrollView addSubview:contentView];
    [scrollView setContentSize:contentView.frame.size];
    [scrollView setDelegate:self];
    
    imageView_Background.layer.masksToBounds = NO;
    imageView_Background.layer.shadowOffset = CGSizeMake(4, 5);
    imageView_Background.layer.shadowRadius = 11.5;
    imageView_Background.layer.shadowOpacity = 0.15;
}


#pragma mark - Animation
-(void)startSwitchAnimation {
    [manager setContentKey:CONTENT_KEY_01];
    [scrollView removeFromSuperview];
    
    [self.view addSubview:view_Animated];
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = [imageView_Background frame];
        frame.size.width -= frame.size.width / 10;
        frame.size.height -= frame.size.height / 10;
        frame.origin.x += frame.size.width / 20;
        frame.origin.y += frame.size.height / 20;
        [imageView_Background setFrame:frame];
        
        frame = [imageView_TopBackground frame];
        frame.size.width -= frame.size.width / 10;
        frame.size.height -= frame.size.height / 10;
        frame.origin.x += frame.size.width / 20;
        frame.origin.y += frame.size.height / 20;
        [imageView_TopBackground setFrame:frame];
    } completion:^(BOOL finished) {
        
    }];
    
//    [self performSegueWithIdentifier:@"ShowMovieSegue" sender:nil];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)_scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat targetX = scrollView.contentOffset.x + velocity.x * 60.0;
    CGFloat indexWidth = contentView.frame.size.width / 4;
    CGFloat indexMargin = indexWidth / 2;
    CGFloat moveToX = 0;
    
    targetContentOffset->x = _scrollView.contentOffset.x;
    
    if (targetX < indexWidth - indexMargin)
        moveToX = 0;
    else if (targetX > indexWidth * 2 - indexMargin && targetX < indexWidth * 3 - indexMargin)
        moveToX = indexWidth * 2;
    else if (targetX > indexWidth * 3 - indexMargin && targetX < indexWidth * 4 - indexMargin)
        moveToX = scrollView.contentSize.width - scrollView.frame.size.width;
    else
        moveToX = 378-43;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2f animations:^{
            [_scrollView setContentOffset:CGPointMake(moveToX, 0)];
        }];
    });
}


#pragma mark - IBActions
-(IBAction)action_Select:(UIButton *)sender {
    NSLog(@"select tale : %d", (int)sender.tag);
    switch (sender.tag) {
        case 0:
            [self startSwitchAnimation];
            break;
            
        case 1:
            break;
            
        case 2:
            break;
            
        default:
            break;
    }
}

-(IBAction)action_Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Override
-(BOOL)prefersStatusBarHidden {
    return YES;
}


@end
