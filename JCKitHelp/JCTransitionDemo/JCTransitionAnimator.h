//
//  JCTransitionAnimator.h
//  JCKitHelp
//
//  Created by seris-Jam on 16/10/10.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCTransitionAnimator : NSObject <UINavigationControllerDelegate>

//转场动画时间默认0.5秒
@property (nonatomic, assign) NSTimeInterval duration;

@end
