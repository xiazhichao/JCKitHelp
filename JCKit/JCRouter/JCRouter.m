//
//  JCRouter.m
//  JCKitHelp
//
//  Created by 贾淼 on 16/9/29.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "JCRouter.h"
#import "JCRouterParams.h"


@interface JCRouter ()

@property (nonatomic, strong) NSMutableDictionary *routes;
@property (nonatomic, strong) NSMutableDictionary *cacheRoutes;

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
    if (!key) {
        @throw [NSException exceptionWithName:@"映射路由不能创建"
                                       reason:@"路由映射关键值不能为空"
                                     userInfo:nil];
        return;
    }
    
    [self.routes setObject:controllerClass forKey:key];
}

- (void)pushURL:(NSString *)urlString {
    [self pushURL:urlString extraParams:nil];
}

- (void)pushURL:(NSString *)urlString extraParams:(NSDictionary *)extraParams {
    [self pushURL:urlString extraParams:extraParams animated:YES];
}

- (void)pushURL:(NSString *)urlString extraParams:(NSDictionary *)extraParams animated:(BOOL)animated {
    JCRouterParams *routerParams = [self routerParamsForUrl:urlString withextraParams:extraParams];
    UIViewController *controller = [self controllerForRouterOption:routerParams];
    
    if ([self.rootViewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)self.rootViewController pushViewController:controller animated:YES];
    }
}

//构造一个JCRouterPararms
- (JCRouterParams *)routerParamsForUrl:(NSString *)urlString withextraParams:(NSDictionary *)extraParams {
    if (!urlString) {
        @throw [NSException exceptionWithName:@"映射路由不能创建"
                                       reason:@"路由映射路径不能为空"
                                     userInfo:nil];
    }
    
    if ([self.cacheRoutes objectForKey:urlString] && !extraParams) {
        return [self.cacheRoutes objectForKey:urlString];
    }
    
    NSArray *parts = urlString.pathComponents;
    NSArray *paramsParts = [urlString componentsSeparatedByString:@"/"];
    
    if ([parts count] != [paramsParts count]) {
        parts = paramsParts;
    }
    
    __block JCRouterParams *routerParams = nil;
    
    [self.routes enumerateKeysAndObjectsUsingBlock:^(NSString *routerUrl, Class controllerClass, BOOL *stop){
        NSArray *routerParts = [routerUrl pathComponents];
        
        if ([routerParts count] == [paramsParts count]) {
            NSDictionary *givenParams = [self paramsForUrlComponents:parts routerUrlComponents:routerParts];
            if (givenParams) {
                routerParams = [[JCRouterParams alloc] initWithControllerClass:controllerClass openParams:givenParams extraParams: extraParams];
                *stop = YES;
            }
        }
    }];
    
    if (!routerParams) {
        @throw [NSException exceptionWithName:@"映射路由不能创建"
                                       reason:@"路由映射路径不能为空"
                                     userInfo:nil];
    }
    
    [self.cacheRoutes setObject:routerParams forKey:urlString];
    return routerParams;
}

- (NSDictionary *)paramsForUrlComponents:(NSArray *)givenUrlComponents
                     routerUrlComponents:(NSArray *)routerUrlComponents {
    
    __block NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [routerUrlComponents enumerateObjectsUsingBlock:
     ^(NSString *routerComponent, NSUInteger idx, BOOL *stop) {
         
         NSString *givenComponent = givenUrlComponents[idx];
         if ([routerComponent hasPrefix:@":"]) {
             NSString *key = [routerComponent substringFromIndex:1];
             [params setObject:givenComponent forKey:key];
         }
         else if (![routerComponent isEqualToString:givenComponent]) {
             params = nil;
             *stop = YES;
         }
     }];
    return params;
}

- (UIViewController *)controllerForRouterOption:(JCRouterParams *)routerParams {
    SEL CONTROLLER_CLASS_SELECTOR = sel_registerName("allocWithRouterParams:");
    SEL CONTROLLER_SELECTOR = sel_registerName("initWithRouterParams:");
    UIViewController *controller = nil;
    
    Class controllerClass = routerParams.controllerClass;
    
    if ([controllerClass respondsToSelector:CONTROLLER_CLASS_SELECTOR]) {
        NSMethodSignature *sig  = [controllerClass methodSignatureForSelector:CONTROLLER_CLASS_SELECTOR];
        NSInvocation *invocatin = [NSInvocation invocationWithMethodSignature:sig];
        [invocatin setTarget:controllerClass];
        [invocatin setSelector:CONTROLLER_CLASS_SELECTOR];
        NSDictionary *paramsDic = [routerParams controllerParams];
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
        NSDictionary *paramsDic = [routerParams controllerParams];
        [invocatin setArgument:&paramsDic atIndex:2];
        [invocatin invoke];
        controller = target;
    }
    
    return controller;
}

//Stack operations
- (void)popViewControllerFromRouterAnimated:(BOOL)animated {
    if (self.rootViewController.presentedViewController) {
        [self.rootViewController dismissViewControllerAnimated:animated completion:nil];
    }
    else {
        [(UINavigationController *)self.rootViewController popViewControllerAnimated:animated];
    }
}
- (void)pop {
    [self popViewControllerFromRouterAnimated:YES];
}

- (void)pop:(BOOL)animated {
    [self popViewControllerFromRouterAnimated:animated];
}

@end
