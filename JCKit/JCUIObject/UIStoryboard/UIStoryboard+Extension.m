//
//  UIStoryboard+Extension.m
//  JCKitHelp
//
//  Created by seris-Jam on 16/9/27.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "UIStoryboard+Extension.h"

@implementation UIStoryboard (Extension)

+ (id)storyboardWithName:(NSString *)name identifier:(NSString *)identifier {
    UIStoryboard *storyboard = [self storyboardWithName:name bundle:nil];
    
    UIViewController *viewController;
    
    if (identifier) {
        viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    } else {
        viewController = [storyboard instantiateInitialViewController];
    }
    
    return viewController;
}

@end
