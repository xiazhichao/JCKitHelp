//
//  JCTransitionAnimator.m
//  JCKitHelp
//
//  Created by seris-Jam on 16/10/10.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "JCTransitionAnimator.h"
#import <objc/runtime.h>

@interface JCTransitionAnimator ()

@property (nonatomic, strong) JCTransition *pushTransition;
@property (nonatomic, strong) JCTransition *popTranstion;

@end

NSString *const kJCAnimatorKey = @"JC_Animator";

@implementation JCTransitionAnimator

- (void)dealloc {
    NSLog(@"dealloc");
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
    }
    
    return self;
}

- (instancetype)initPushTransition:(JCTransition *)pushTransition withPopTransition:(JCTransition *)popTransition {
    self = [super init];
    
    if (self) {
        self.pushTransition = pushTransition;
        self.popTranstion = popTransition;
    }
    
    return self;
}

#pragma mark UINavigationDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        objc_setAssociatedObject(toVC, &kJCAnimatorKey, self, OBJC_ASSOCIATION_RETAIN);
        [self checkTransition:self.popTranstion WithViewController:toVC];
        return [self checkTransition:self.pushTransition WithViewController:toVC];
    } else {
        return [self checkTransition:self.popTranstion WithViewController:toVC];
    }
    return nil;
}

- (JCTransition *)checkTransition:(JCTransition *)transition WithViewController:(UIViewController *)viewController {
    if (!transition) {
        viewController.navigationController.delegate = nil;
        return nil;
    }
    
    return transition;
}

@end
