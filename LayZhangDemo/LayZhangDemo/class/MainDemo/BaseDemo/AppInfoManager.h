//
//  AppInfoManager.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AppBundleState) {
    AppBundleNewInstalled  = 0,
    AppBundleNormal        = 1,
    AppBundleUpdated       = 2,
    AppBundleDowngrade     = 3,
};


@interface AppInfoManager : NSObject


+ (NSString*)shortVersionString;

+ (NSString*)bundleVersion;

+ (NSString*)identifierKey;

+ (AppBundleState)updateAppBundleState;
+ (AppBundleState)getAppBundleState;

@end
