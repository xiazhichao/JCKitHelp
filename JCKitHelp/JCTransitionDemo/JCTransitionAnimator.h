//
//  JCTransitionAnimator.h
//  JCKitHelp
//
//  Created by seris-Jam on 16/10/10.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JCTransition.h"

@interface JCTransitionAnimator : NSObject <UINavigationControllerDelegate>

- (instancetype)initPushTransition:(JCTransition *)pushTransition withPopTransition:(JCTransition *)popTransition;

@end
