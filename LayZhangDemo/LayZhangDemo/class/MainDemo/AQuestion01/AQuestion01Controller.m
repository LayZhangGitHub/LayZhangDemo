//
//  AQuestion01Controller.m
//  LayZhangDemo
//
//  Created by WorkLay on 2018/11/13.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "AQuestion01Controller.h"

// 网络请求向服务器轮询，直到服务器返回成功。
// 最多尝试次数10次
// 每次请求间隔 3 秒

static int count = 0;

@interface AQuestion01Controller ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AQuestion01Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"Q01" withLeft:[UIImage imageNamed:@"icon_back"]];
    
    
    [self startLongPolling];
}

- (void)startLongPolling {
    NSThread *thread = [[NSThread alloc] initWithTarget:self
                                               selector:@selector(threadEndPoint)
                                                 object:nil];
    [thread start];
}

- (void)threadEndPoint {
    [[NSThread currentThread] setName:@"PollingThread"];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(requestUnit) userInfo:nil repeats:YES];
    [runLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
    BOOL exitNow = NO;
    NSMutableDictionary* threadDict = [[NSThread currentThread] threadDictionary];
    [threadDict setValue:[NSNumber numberWithBool:exitNow] forKey:@"ThreadShouldExitNow"];
    
    while (!exitNow) {
        NSLog(@"while begin");
        [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        exitNow = [[threadDict valueForKey:@"ThreadShouldExitNow"] boolValue];
        NSLog(@"while end");
    }
}

- (void)requestUnit {
    NSLog(@"TODO request");
    count++;
    BOOL exitNow = (count == 5);
    NSMutableDictionary* threadDict = [[NSThread currentThread] threadDictionary];
    [threadDict setValue:[NSNumber numberWithBool:exitNow] forKey:@"ThreadShouldExitNow"];
    NSLog(@"count is %d", count);
    NSLog(@"begin request");
    sleep(3.0);
    NSLog(@"end request");
    if (exitNow) {
        [self.timer invalidate];
    }
}

@end
