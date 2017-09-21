//
//  ZLNavigationService.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLNavigationService.h"
#import "ZLModuleEntity.h"

@interface ZLNavigationService ()

// 保存已经注册的 路由模块信息
// scheme --> host --> moduleEntity
@property (nonatomic, strong) NSMutableDictionary *registeredModules;

@end

@implementation ZLNavigationService

+ (instancetype)sharedService {
    static dispatch_once_t onceToken;
    static ZLNavigationService *service = nil;
    dispatch_once(&onceToken, ^{
        service = [[ZLNavigationService alloc] init];
    });
    return service;
}

#pragma mark - property
- (NSMutableDictionary *)registeredModules {
    if (!_registeredModules) {
        _registeredModules = [NSMutableDictionary dictionary];
    }
    return _registeredModules;
}

#pragma mark - reigiste
- (void)registerModule:(Class)moduleClass withScheme:(NSString *)scheme host:(NSString *)host {
    if (!scheme) {
        return;
    }
    
    if ([moduleClass isSubclassOfClass:[ZLModuleEntity class]]) {
        // 生成 实例 对象
        ZLModuleEntity *moduleEntity = [moduleClass performSelector:@selector(sharedEntity)];
        if (moduleEntity) {
            NSMutableDictionary *hostDict = self.registeredModules[scheme];
            if (!hostDict) {
                hostDict = [NSMutableDictionary dictionary];
                [self.registeredModules setObject:hostDict forKey:scheme];
            }
            if (IsEmptyString(host)) {
                [hostDict setObject:moduleEntity forKey:[NSNull null]];
            } else {
                [hostDict setObject:moduleEntity forKey:host];
            }
        } else {
            ZLErrorLog(@"error: 未实现 %@ 的 sharedEntrance 方法", moduleClass);
        }
    }
}

#pragma mark - open url
- (void)openUrl:(NSString *)urlString {
    [self openUrl:urlString userInfo:nil];
}

- (void)openUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo {
    [self openUrl:urlString userInfo:userInfo from:nil complete:nil];
}

- (void)openUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void (^)())complete {
    
    if (!IsEmptyString(urlString)) {
        
        NSString *resultUrlString = [urlString trim];
        NSString *strUrl = [resultUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:strUrl];
        
        // 若没有scheme 默认 http
        if (IsEmptyString(url.scheme) && !IsEmptyString(resultUrlString)) {
            if (![resultUrlString hasPrefix:@"http://"]) {
                NSString *preUrl = @"http://";
                resultUrlString = [NSString stringWithFormat:@"%@%@", preUrl, resultUrlString];
                url = [NSURL URLWithString:resultUrlString];
            }
        }
        
        if (url) {
            id host = [NSNull null];
            if (!IsEmptyString(url.host)) {
                host = url.host;
            }
            
            ZLModuleEntity *moduleEntity = self.registeredModules[url.scheme][host];
            if (moduleEntity) {
                [moduleEntity handleOpenUrl:resultUrlString userInfo:userInfo from:from complete:complete];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:resultUrlString]
                                                   options:@{}
                                         completionHandler:nil];
            }
        }
    }
}

- (BOOL)canOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from {
    BOOL result = NO;
    
    NSString *resultUrlString = [urlString trim];
    
    NSURL *url = [NSURL URLWithString:resultUrlString];
    
    if (url) {
        id host = [NSNull null];
        if (!IsEmptyString(url.host)) {
            host = url.host;
        }
        
        ZLModuleEntity *moduleEntity = self.registeredModules[url.scheme][host];
        
        if (moduleEntity) {
            result = [moduleEntity canOpenUrl:resultUrlString userInfo:userInfo from:from];
        }
        
    }
    return result;
}
@end
