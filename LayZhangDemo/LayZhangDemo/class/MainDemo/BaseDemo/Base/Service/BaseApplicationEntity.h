//
//  ZLApplicationEntity.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLTabbarController.h"
#import "ZLNavigationController.h"


@interface BaseApplicationEntity : NSObject

@property(nonatomic, strong) ZLTabbarController *tabbarController;
@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) ZLNavigationController *currentNavController;

+ (instancetype)shareInstance;

- (ZLNavigationController *)currentNavigationController;

- (void)applicationEntrance:(UIWindow *)mainWindow launchOptions:(NSDictionary *)launchOptions;
- (void)applicationEnterForeground;
- (void)applicationActive;
- (void)applicationEnterBackground;
- (void)handleOpenURL:(NSString *)aUrl;
- (void)applicationRegisterDeviceToken:(NSData*)deviceToken;
- (void)applicationFailToRegisterDeviceToken:(NSError*)error;
- (void)applicationReceiveNotifaction:(NSDictionary*)userInfo;
- (BOOL)applicationOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)applicationHandleOpenURL:(NSURL *)url;

- (void)applicationPerformFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

@end
