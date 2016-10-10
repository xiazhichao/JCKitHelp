//
//  JCTransitionObject.m
//  JCKitHelp
//
//  Created by seris-Jam on 16/10/10.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "JCTransitionObject.h"

@implementation JCTransitionObject {
    NSTimeInterval _duration;
    JCTransitionCustomConfig _customConfigTransitionBlock;
}

- (instancetype)initWithDuration:(NSTimeInterval)duration animationBlock:(void(^)(id<UIViewControllerContextTransitioning> transitionContext))customConfigTransition {
    self = [super init];
    
    if (self) {
        _duration = duration;
        _customConfigTransitionBlock = customConfigTransition;
    }
    
    return self;
}

#pragma mark UIViewControllerAnimatedTransitioning 

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return _duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning> __nonnull)transitionContext {
    if (_customConfigTransitionBlock) {
        _customConfigTransitionBlock(transitionContext);
    }
}

@end
