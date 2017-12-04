//
//  PollingManager.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/6/12.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PollingManager.h"
#import "PollingTask.h"

#define REQUESTMAXTIME 10

static NSMutableSet *requestSet = nil;

static void ZLRequestSetup() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestSet = [NSMutableSet new];
    });
}

@interface PollingManager()

@end

@implementation PollingManager

- (void)commitPollingTask:(PollingTask *)pollingTask {
    ZLRequestSetup();
    
    [self performSelector:@selector(operator:)
                 onThread:[[self class] networkRequestThread]
               withObject:pollingTask
            waitUntilDone:NO
                    modes:@[NSRunLoopCommonModes]];
}

- (void)operator:(PollingTask *)pollingTask {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:pollingTask.timeInteval
                                                      target:pollingTask.target
                                                    selector:pollingTask.selector
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)removePollingTask:(PollingTask *)pollingTask {
    [requestSet removeObject:pollingTask];
}

+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"thread.polling.demo"];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

+ (NSThread *)networkRequestThread {
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });
    
    return _networkRequestThread;
}





// 因为时间间隔 和 执行次数 不一样， 而且这样的轮询 请求 并不多， 所以 每一个轮询请求 开一条线程
//- (void)startPollingWithTask:(PollingTask *)pollingTask {
//    @autoreleasepool {
//        [[NSThread currentThread] setName:@"thread.polling.demo"];
//        
//        NSRunLoop * myRunLoop =[NSRunLoop currentRunLoop];
//        CFRunLoopObserverContext context = {0, (__bridge_retained void *)pollingTask, NULL, NULL, NULL};
//        CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &myRunLoopObserver, NULL);
//        if (observer) {
//            CFRunLoopRef cfRunloop = [myRunLoop getCFRunLoop];
//            CFRunLoopAddObserver(cfRunloop, observer, kCFRunLoopDefaultMode);
//        }
//        while ([requestSet containsObject:pollingTask]) {
////            count ++;
//            sleep(1);
//            NSLog(@"...");
//            [myRunLoop run];
////            if (count > pollingTask.maxPollingTimes) {
////                [self removePollingTask:pollingTask];
////            }
//        }
//        
//    }
//}
//
//- (void)test {}

//
//+ (void)networkRequestThreadEntryPoint:(PollingConfig *)pollingConfig {
//    @autoreleasepool {
//        [[NSThread currentThread] setName:pollingConfig.pollingName];
//
//        NSRunLoop * myRunLoop =[NSRunLoop currentRunLoop];
//        CFRunLoopObserverContext context = {0, (__bridge_retained void *)self, NULL, NULL, NULL};
//        CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &myRunLoopObserver, &context);
//        if (observer) {
//            CFRunLoopRef cfRunloop = [myRunLoop getCFRunLoop];
//            CFRunLoopAddObserver(cfRunloop, observer, kCFRunLoopDefaultMode);
//        }
//        while (pollingConfig) {
//            [myRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];
//        }
//
////        while (true) {
////            NSLog(@"begin");
////            [runLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];
////        }
//
////        [runLoop run];
//    }
//}

//+ (NSThread *)networkRequestThread {
//    static NSThread *_networkRequestThread = nil;
//    static dispatch_once_t oncePredicate;
//    dispatch_once(&oncePredicate, ^{
//        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
//        [_networkRequestThread start];
//    });
//
//    return _networkRequestThread;
//}

//- (void)commit {
//    [self performSelector:@selector(doPolling)
//                 onThread:[[self class] networkRequestThread]
//               withObject:nil
//            waitUntilDone:NO
//                    modes:@[NSRunLoopCommonModes]];
//}

//- (void)doPolling {
//
//    [PollingModel requestFinishedBlock:^(id object) {
//        if ([object isEqualToString:@"timeout"]) {
//            NSLog(@"time out");
////            [self commit];
//
////            [self requestAndPrint];
//        } else {
//            NSLog(@"success");
//        }
//    } failuredBlock:^(id object) {
//        NSLog(@"faield");
////        [self commit];
//
////        [self requestAndPrint];
//    }];
//}


//- (void)request {
//
//    if (self.requestTime >= REQUESTMAXTIME) {
//        NSLog(@"请求 失败 超过 10 次");
//        self.isRequesting = false;
//        return;
//    }
//    self.requestTime++;
//    //网络请求
//    [PollingModel requestFinishedBlock:^(id object) {
//        if ([object isEqualToString:@"timeout"]) {
//            [self requestAndPrint];
//        } else {
//            NSLog(@"success");
//            self.isRequesting = false;
//        }
//    } failuredBlock:^(id object) {
//        [self requestAndPrint];
//    }];
//}

//- (void)requestAndPrint{
////    NSLog(@"第%lu次请求 timeout", (unsigned long)self.requestTime);
////    NSLog(@"%@", [NSThread currentThread]);
////    [NSThread sleepForTimeInterval:3];
////    [self request];
//}

@end
