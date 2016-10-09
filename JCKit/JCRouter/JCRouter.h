//
//  JCRouter.h
//  JCKitHelp
//
//  Created by 贾淼 on 16/9/29.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCRouter : NSObject

@property (nonatomic, assign) UIViewController *rootViewController;
@property (nonatomic, strong) Class defaultNavigationClass;

+ (instancetype)shareRouter;

- (void)mapKey:(NSString *)key toController:(Class)controllerClass;

- (void)pushURL:(NSString *)urlString;
- (void)pushURL:(NSString *)urlString extraParams:(NSDictionary *)extraParams;
- (void)pushURL:(NSString *)urlString extraParams:(NSDictionary *)extraParams animated:(BOOL)animated;



@end
