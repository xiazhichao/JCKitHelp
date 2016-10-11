//
//  JCTransition.h
//  JCKitHelp
//
//  Created by seris-Jam on 16/10/11.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCTransition : NSObject <UIViewControllerAnimatedTransitioning>

//转场动画时间默认0.5秒
@property (nonatomic, assign) NSTimeInterval duration;

@end
