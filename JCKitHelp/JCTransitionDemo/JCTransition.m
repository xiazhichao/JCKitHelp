//
//  JCTransition.m
//  JCKitHelp
//
//  Created by seris-Jam on 16/10/11.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "JCTransition.h"

@implementation JCTransition

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.duration = 3.0f;
    }
    
    return self;
}

#pragma mark UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return _duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalFrameForVC = [transitionContext finalFrameForViewController:toViewController];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    toViewController.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height);
    [[transitionContext containerView] addSubview:toViewController.view];
    
    [UIView animateWithDuration:self.duration delay:0.3f usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        fromViewController.view.alpha = 0.8f;
        toViewController.view.frame = finalFrameForVC;
    } completion:^(BOOL finished){
        [transitionContext completeTransition:YES];
        fromViewController.view.alpha = 1.0f;
    }];
}

@end
