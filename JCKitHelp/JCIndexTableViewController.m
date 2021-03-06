//
//  JCIndexTableViewController.m
//  JCKitHelp
//
//  Created by 贾淼 on 16/9/22.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "JCIndexTableViewController.h"
#import "JCNavigationViewController.h"
#import "JCRouter.h"

@interface JCIndexTableViewController ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *classNames;

@end

@implementation JCIndexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"UITabBarItem动画效果", @"转场动画效果"];
    
    self.classNames = @[@"JCTabBarViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    [cell.textLabel setText:self.titles[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [[JCRouter shareRouter] presentURL:@"tabController/4/title" withNavigationClass:[JCNavigationViewController class] completion:nil];
        return;
    }
    
    [[JCRouter shareRouter] pushURL:@"TransitionDemo"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
