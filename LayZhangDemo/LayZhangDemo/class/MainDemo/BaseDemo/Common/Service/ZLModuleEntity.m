//
//  ZLModuleEntity.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLModuleEntity.h"

@implementation ZLModuleEntity

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)addNotification {
    [DefaultNotificationCenter addObserver:self selector:@selector(applicationDidEnterBackground:)
                                      name:UIApplicationDidEnterBackgroundNotification object:nil];
    [DefaultNotificationCenter addObserver:self selector:@selector(applicationWillEnterForeground:)
                                      name:UIApplicationWillEnterForegroundNotification object:nil];
    [DefaultNotificationCenter addObserver:self selector:@selector(applicationDidFinishLaunching:)
                                      name:UIApplicationDidFinishLaunchingNotification object:nil];
    [DefaultNotificationCenter addObserver:self selector:@selector(applicationDidBecomeActive:)
                                      name:UIApplicationDidBecomeActiveNotification object:nil];
    [DefaultNotificationCenter addObserver:self selector:@selector(applicationWillResignActive:)
                                      name:UIApplicationWillResignActiveNotification object:nil];
    [DefaultNotificationCenter addObserver:self selector:@selector(applicationDidReceiveMemoryWarning:)
                                      name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    [DefaultNotificationCenter addObserver:self selector:@selector(applicationWillTerminate:)
                                      name:UIApplicationWillTerminateNotification object:nil];
    [DefaultNotificationCenter addObserver:self selector:@selector(applicationSignificantTimeChange:)
                                      name:UIApplicationSignificantTimeChangeNotification object:nil];
}

- (BOOL)canOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from {
    return YES;
}

- (void)handleOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void(^)())complete {
    
}

- (void)dealloc {
    [DefaultNotificationCenter removeObserver:self];
}

#pragma mark - app entity

- (void)applicationDidEnterBackground:(NSNotification *)notification { }
- (void)applicationWillEnterForeground:(NSNotification *)notification { }
- (void)applicationDidFinishLaunching:(NSNotification *)notification { }
- (void)applicationDidBecomeActive:(NSNotification *)notification { }
- (void)applicationWillResignActive:(NSNotification *)notification { }
- (void)applicationDidReceiveMemoryWarning:(NSNotification *)notification { }
- (void)applicationWillTerminate:(NSNotification *)notification { }
- (void)applicationSignificantTimeChange:(NSNotification *)notification { }

@end
