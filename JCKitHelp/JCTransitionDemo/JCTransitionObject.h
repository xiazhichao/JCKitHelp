//
//  JCTransitionObject.h
//  JCKitHelp
//
//  Created by seris-Jam on 16/10/10.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JCTransitionCustomConfig)(id<UIViewControllerAnimatedTransitioning> transitioning);

@interface JCTransitionObject : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithDuration:(NSTimeInterval)duration animationBlock:(JCTransitionCustomConfig)customConfigTransition;

@end
