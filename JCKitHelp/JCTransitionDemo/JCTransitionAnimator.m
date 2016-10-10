//
//  JCTransitionAnimator.m
//  JCKitHelp
//
//  Created by seris-Jam on 16/10/10.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "JCTransitionAnimator.h"

@interface JCTransitionAnimator ()

@property (nonatomic, assign) UINavigationControllerOperation operation;

@end

@implementation JCTransitionAnimator

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.duration = 0.5f;
    }
    
    return self;
}

#pragma mark UINavigationDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    _operation = operation;
    return operation == UINavigationControllerOperationPush ? self.toTransition : self.backTranstion;
}

@end
