//
//  AppInfoManager.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "AppInfoManager.h"

#define AppLastVersion @"AppLastVersion"

@implementation AppInfoManager

+ (NSString*)shortVersionString {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}

+ (NSString*)bundleVersion {
    return [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey];
}

+ (NSString*)identifierKey {
    return [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey];
}

+ (AppBundleState)updateBundleState {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:AppLastVersion];
    NSString *nowVersion = [AppInfoManager shortVersionString];
    if (!lastVersion) {
        [defaults setObject:nowVersion forKey:AppLastVersion];
        [defaults synchronize];
        //新装
        return AppBundleNewInstalled;
    }else{
        NSComparisonResult updated = [lastVersion compare:nowVersion options:NSNumericSearch];
        AppBundleState result;
        switch (updated) {
            case NSOrderedAscending:
                result = AppBundleUpdated;
                break;
            case NSOrderedSame:
                result = AppBundleNormal;
                break;
            case NSOrderedDescending:
                result = AppBundleDowngrade;
            default:
                break;
        }
        [defaults setObject:nowVersion forKey:AppLastVersion];
        [defaults synchronize];
        return result;
    }
}

+ (AppBundleState)getAppBundleState
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:AppLastVersion];
    NSString *nowVersion = [AppInfoManager shortVersionString];
    if (!lastVersion) {
        //新装
        return AppBundleNewInstalled;
    }else{
        NSComparisonResult updated = [lastVersion compare:nowVersion options:NSNumericSearch];
        AppBundleState result;
        switch (updated) {
            case NSOrderedAscending:
                result = AppBundleUpdated;
                break;
            case NSOrderedSame:
                result = AppBundleNormal;
                break;
            case NSOrderedDescending:
                result = AppBundleDowngrade;
            default:
                break;
        }
        return result;
    }
}
@end
