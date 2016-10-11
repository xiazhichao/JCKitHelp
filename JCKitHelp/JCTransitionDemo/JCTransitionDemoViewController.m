//
//  JCTransitionDemoViewController.m
//  JCKitHelp
//
//  Created by 贾淼 on 16/9/27.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "JCTransitionDemoViewController.h"
#import "JCRouter.h"
#import "UIViewController+JCNavigationControllerExtension.h"
#import "JCBaseTransitionAnimator.h"

@interface JCTransitionDemoViewController ()

@end

@implementation JCTransitionDemoViewController

+ (id)allocWithRouterParams:(NSDictionary *)params {
    JCTransitionDemoViewController *instance = [[UIStoryboard storyboardWithName:@"TransitionDemo" bundle:nil] instantiateInitialViewController];
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // Configure the cell...
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JCBaseTransitionAnimator *animator = [[JCBaseTransitionAnimator alloc] init];
    [[JCRouter shareRouter] currentNavigationViewController].delegate = animator;
    [[JCRouter shareRouter] pushURL:@"pageController"];
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
