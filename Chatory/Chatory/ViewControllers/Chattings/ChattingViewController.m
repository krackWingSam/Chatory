//
//  ChattingViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 20..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "ChattingViewController.h"

@interface ChattingViewController () <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIView *view_Navigation;
    IBOutlet UIView *view_Navigation_Upper;
    
    NSMutableArray *array_Contents;
}

@end

@implementation ChattingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    array_Contents = [[NSMutableArray alloc] init];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI {
    //TODO: initializing view controller's contents
    
//    [view_Navigation.layer setMasksToBounds:YES];
//    [view_Navigation.layer setCornerRadius:20.f];
    
    view_Navigation.layer.cornerRadius = 20;
    view_Navigation.layer.shadowColor = [UIColor blackColor].CGColor;
    view_Navigation.layer.shadowOffset = CGSizeMake(0, 4.0);
    view_Navigation.layer.shadowOpacity = 0.05;
    view_Navigation.layer.shadowRadius = 5.0;
}


#pragma mark - Properties
-(void)setContentDic:(NSDictionary *)contentDic {
    _contentDic = contentDic;
    //TODO: set contents for character, questions, answers or etc
}


#pragma mark - UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell"];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [array_Contents count];
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = [array_Contents objectAtIndex:indexPath.row];
    
    return 368.f;
}


@end
