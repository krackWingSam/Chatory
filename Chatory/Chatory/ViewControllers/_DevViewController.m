//
//  _DevViewController.m
//  Chatory
//
//  Created by askstory on 2017. 9. 19..
//  Copyright © 2017년 askstory. All rights reserved.
//

#import "_DevViewController.h"

@interface _DevViewController () {
    IBOutlet UITableView *table_DevList;
    
    NSArray *array_TableCellTitles;
}

@end

@implementation _DevViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    array_TableCellTitles = @[@"vc1", @"vc2", @"vc3"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [array_TableCellTitles count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell.textLabel setText:[array_TableCellTitles objectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"table view cell selected : %ld", (long)indexPath.row);
}



@end
