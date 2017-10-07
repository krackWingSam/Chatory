//
//  Chat_LoadingViewController.h
//  Chatory
//
//  Created by askstory on 2017. 9. 27..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Chat_LoadingViewControllerDelegate <NSObject>

-(void)doneLoadingAnimation;

@end


@interface Chat_LoadingViewController : UIViewController

-(void)showDotAnimation;

@property (nonatomic, getter=isShowIcon) BOOL showIcon;
@property Teacher *teacher;

@property id<Chat_LoadingViewControllerDelegate> delegate;

@end
