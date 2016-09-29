//
//  JCRouter.m
//  JCKitHelp
//
//  Created by 贾淼 on 16/9/29.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "JCRouter.h"

@interface JCRouterOption ()

@property (nonatomic, strong) Class controllerClass;
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation JCRouterOption

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

@end


@interface JCRouter ()

@property (readwrite, nonatomic, strong) NSMutableDictionary *routes;

@end

@implementation JCRouter

+ (instancetype)shareRouter {
    static JCRouter *shareRouter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareRouter = [[JCRouter alloc] init];
    });
    
    return shareRouter;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.routes = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)mapKey:(NSString *)key toController:(Class)controllerClass {
    [self mapKey:key toController:controllerClass withOption:nil];
}

- (void)mapKey:(NSString *)key toController:(Class)controllerClass withOption:(JCRouterOption*)routerOption {
    if (!key) {
        @throw [NSException exceptionWithName:@"映射路由不能创建"
                                       reason:@"路由映射关键值不能为空"
                                     userInfo:nil];
        return;
    }
    
    if (!routerOption) {
        routerOption = [[JCRouterOption alloc] init];
    }
    routerOption.controllerClass = controllerClass;
    
    [self.routes setObject:routerOption forKey:key];
}

- (void)openURL:(NSString *)urlString {
    [self openURL:urlString extraParams:nil];
}

- (void)openURL:(NSString *)urlString extraParams:(NSDictionary *)extraParams {
    [self openURL:urlString extraParams:extraParams animated:NO];
}

- (void)openURL:(NSString *)urlString extraParams:(NSDictionary *)extraParams animated:(BOOL)animated {
    JCRouterOption *routerOption = [self.routes objectForKey:urlString];
    routerOption.params = extraParams;
    
    UIViewController *controller = [self controllerForRouterOption:routerOption];
    
    [self.rootViewController pushViewController:controller animated:animated];
}

- (UIViewController *)controllerForRouterOption:(JCRouterOption *)routerOption {
    SEL CONTROLLER_CLASS_SELECTOR = sel_registerName("allocWithRouterParams:");
    SEL CONTROLLER_SELECTOR = sel_registerName("initWithRouterParams:");
    UIViewController *controller = nil;
    Class controllerClass = routerOption.controllerClass;
    
    if ([controllerClass respondsToSelector:CONTROLLER_CLASS_SELECTOR]) {
        NSMethodSignature *sig  = [controllerClass methodSignatureForSelector:CONTROLLER_CLASS_SELECTOR];
        NSInvocation *invocatin = [NSInvocation invocationWithMethodSignature:sig];
        [invocatin setTarget:controllerClass];
        [invocatin setSelector:CONTROLLER_CLASS_SELECTOR];
        NSDictionary *paramsDic = [routerOption params];
        [invocatin setArgument:&paramsDic atIndex:2];
        [invocatin invoke];
        [invocatin getReturnValue: &controller];
    }
    else if ([controllerClass instancesRespondToSelector:CONTROLLER_SELECTOR]) {
        UIViewController *target = [controllerClass alloc];
        NSMethodSignature *sig  = [controllerClass instanceMethodSignatureForSelector:CONTROLLER_SELECTOR];
        NSInvocation *invocatin = [NSInvocation invocationWithMethodSignature:sig];
        [invocatin setTarget:target];
        [invocatin setSelector:CONTROLLER_SELECTOR];
        NSDictionary *paramsDic = [routerOption params];
        [invocatin setArgument:&paramsDic atIndex:2];
        [invocatin invoke];
        controller = target;
    }
    
    return controller;
}

@end
