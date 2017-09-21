//
//  ApplicationEntity.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLApplicationEntity.h"

@implementation ZLApplicationEntity

#pragma mark - application system
- (void)applicationEntrance:(UIWindow *)mainWindow launchOptions:(NSDictionary *)launchOptions {
    [super applicationEntrance:mainWindow launchOptions:launchOptions];
}

- (void)applicationEnterForeground {
    [super applicationEnterForeground];
}

- (void)applicationActive {
    [super applicationActive];
}

- (void)applicationEnterBackground {
    [super applicationEnterBackground];
}

- (void)handleOpenURL:(NSString *)aUrl{
    [super handleOpenURL:aUrl];
}

- (void)applicationRegisterDeviceToken:(NSData*)deviceToken {
    [super applicationRegisterDeviceToken:deviceToken];
}

- (void)applicationFailToRegisterDeviceToken:(NSError*)error {
    [super applicationFailToRegisterDeviceToken:error];
}

- (void)applicationReceiveNotifaction:(NSDictionary*)userInfo {
    [super applicationReceiveNotifaction:userInfo];
}

- (BOOL)applicationOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation { return YES; }

- (BOOL)applicationHandleOpenURL:(NSURL *)url { return YES; }

- (void)applicationPerformFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    completionHandler(UIBackgroundFetchResultNewData);
    
    [self didReceiveRemoteNotification:userInfo];
}

#pragma mark - custom
- (void)didReceiveRemoteNotification:(NSDictionary*)userInfo {
}



@end
