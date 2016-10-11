//
//  JCPageViewController.m
//  JCKitHelp
//
//  Created by 贾淼 on 16/9/27.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "JCPageViewController.h"
#import "UIStoryboard+Extension.h"
#import "UIViewController+JCNavigationControllerExtension.h"
#import "JCRouter.h"

@interface JCPageViewController ()
@end

@implementation JCPageViewController

+ (id)allocWithRouterParams:(NSDictionary *)params {
    JCPageViewController *instance = [UIStoryboard storyboardWithName:@"TransitionDemo" identifier:@"pageController"];
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.jcNavigationController) {
        [self.jcNavigationController removeAtIndex:1];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClickDismiss:(id)sender {
    [[JCRouter shareRouter] ]
    [[JCRouter shareRouter] pushURL:@"pageController"];
}

@end
