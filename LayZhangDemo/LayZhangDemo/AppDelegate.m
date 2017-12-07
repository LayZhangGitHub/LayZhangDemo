//
//  AppDelegate.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FloatNoticeWindow.h"

@interface AppDelegate ()

@property (nonatomic,assign) UIBackgroundTaskIdentifier idf;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self showNoticeWindow];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UIWindow *)showNoticeWindow {
    FloatNoticeWindow *noticeWindow = [[FloatNoticeWindow alloc] initWithFrame:CGRectMake(10, 100, 400 * SCALE, 40 * SCALE)];
    noticeWindow.layer.cornerRadius = 5.0f;
    return noticeWindow;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [self beginTask];
//    //在非主线程开启一个操作在更长时间内执行； 执行的动作
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(go:) userInfo:nil repeats:YES];
}
static int c = 0;
-(void)go:(NSTimer *)tim
{
    c++;
    NSLog(@".......");
    if (c==9) {
        [tim invalidate];
        [self endBack]; // 任务执行完毕，主动调用该方法结束任务
    }
}

-(void)beginTask {
//    NSLog(@"begin=============");
//    self.idf = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//        NSLog(@"begin  bgend=============");
//        [self endBack]; // 如果在系统规定时间内任务还没有完成，在时间到之前会调用到这个方法，一般是10分钟
//    }];
}

-(void)endBack
{
    NSLog(@"end=============");
    [[UIApplication sharedApplication] endBackgroundTask:self.idf];
    self.idf = UIBackgroundTaskInvalid;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
