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
            [manager setContentKey:CONTENT_KEY_01];
            [self performSegueWithIdentifier:@"ShowMovieSegue" sender:nil];
            break;
            
        case 1:
            break;
            
        case 2:
            break;
            
        default:
            break;
    }
}


#pragma mark - Override
-(BOOL)prefersStatusBarHidden {
    return YES;
}


@end
