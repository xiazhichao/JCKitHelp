//
//  AppDelegate.m
//  JCKitHelp
//
//  Created by 贾淼 on 16/9/22.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "AppDelegate.h"

#import "JCRouter.h"

#import "UIStoryboard+Extension.h"

#import "JCNavigationViewController.h"

#import "JCTabBarViewController.h"

#import "JCTransitionDemoViewController.h"

#import "JCPageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIViewController *rootViewController = [UIStoryboard storyboardWithName:@"Main" identifier:nil];
    JCNavigationViewController *navc = [[JCNavigationViewController alloc] initWithRootViewController:rootViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:navc];
    [self.window makeKeyAndVisible];
    
    [[JCRouter shareRouter] mapKey:@"tabController/:id/:userName" toController:[JCTabBarViewController class]];
    [[JCRouter shareRouter] mapKey:@"TransitionDemo" toController:[JCTransitionDemoViewController class]];
    [[JCRouter shareRouter] mapKey:@"pageController" toController:[JCPageViewController class]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
