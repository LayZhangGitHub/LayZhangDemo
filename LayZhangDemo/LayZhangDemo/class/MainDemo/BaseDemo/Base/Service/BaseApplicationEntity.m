//
//  ZLApplicationEntity.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseApplicationEntity.h"

@implementation BaseApplicationEntity


+ (instancetype)shareInstance {
    static BaseApplicationEntity *entrance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        entrance = [[BaseApplicationEntity alloc] init];
    });
    return entrance;
}

- (ZLNavigationController *)currentNavigationController {
    if (self.currentNavController) {
        return self.currentNavController;
    }
    
    UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootController isKindOfClass:[ZLNavigationController class]]) {
        self.currentNavController = (ZLNavigationController *)rootController;
    } else if ([rootController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarController = (UITabBarController *)rootController;
        if ([tabbarController.selectedViewController isKindOfClass:[ZLNavigationController class]]) {
            self.currentNavController = (ZLNavigationController *)tabbarController.selectedViewController;
        }
    }
    return self.currentNavController;
}

- (void)applicationEntrance:(UIWindow *)mainWindow launchOptions:(NSDictionary *)launchOptions {}
- (void)applicationEnterForeground {}
- (void)applicationActive {}
- (void)applicationEnterBackground {}
- (void)handleOpenURL:(NSString *)aUrl{}
- (void)applicationRegisterDeviceToken:(NSData*)deviceToken {}
- (void)applicationFailToRegisterDeviceToken:(NSError*)error {}
- (void)applicationReceiveNotifaction:(NSDictionary*)userInfo {}
- (BOOL)applicationOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation { return YES; }
- (BOOL)applicationHandleOpenURL:(NSURL *)url { return YES; }

- (void)applicationPerformFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {}

- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {}

@end
