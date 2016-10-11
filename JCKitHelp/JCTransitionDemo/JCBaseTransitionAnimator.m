//
//  JCBaseTransitionAnimator.m
//  JCKitHelp
//
//  Created by seris-Jam on 16/10/11.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "JCBaseTransitionAnimator.h"

@implementation JCBaseTransitionAnimator

- (instancetype)init {
    self = [super initPushTransition:[[JCTransition alloc] init] withPopTransition:[[JCTransition alloc] init]];
    
    if (self) {
    }
    
    return self;
}

@end
