//
//  JCRouter.h
//  JCKitHelp
//
//  Created by 贾淼 on 16/9/29.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCRouterOption : NSObject

@end

@interface JCRouter : NSObject

@property (nonatomic, strong) UINavigationController *rootViewController;

+ (instancetype)shareRouter;

- (void)mapKey:(NSString *)key toController:(Class)controllerClass;
- (void)mapKey:(NSString *)key toController:(Class)controllerClass withOption:(JCRouterOption*)routerOption;

- (void)openURL:(NSString *)urlString;
- (void)openURL:(NSString *)urlString extraParams:(NSDictionary *)extraParams;
- (void)openURL:(NSString *)urlString extraParams:(NSDictionary *)extraParams animated:(BOOL)animated;

@end
