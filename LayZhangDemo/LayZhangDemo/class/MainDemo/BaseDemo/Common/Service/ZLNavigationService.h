//
//  ZLNavigationService.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLNavigationService : NSObject

+ (instancetype)sharedService;

- (void)registerModule:(Class)moduleClass withScheme:(NSString *)scheme host:(NSString *)host;
- (void)openUrl:(NSString *)urlString;
- (void)openUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo;
- (void)openUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void(^)())complete;
- (BOOL)canOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from;

@end
