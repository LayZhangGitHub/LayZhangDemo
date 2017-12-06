//
//  PollingOperation.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/12/6.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PollingOperation.h"

@interface PollingOperation()

@property (nonatomic,assign) NSInteger maxTimes; // 最大次数

@property (assign, nonatomic, getter = isFinished) BOOL finished;
@property (assign, nonatomic, getter = isExecuting) BOOL executing;

@end

@implementation PollingOperation

@synthesize finished = _finished;
@synthesize executing = _executing;


//+ (void)startRunloop {
//    @autoreleasepool {
//        [[NSThread currentThread] setName:@"thread.polling.demo"];
//
//        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
////        [runLoop run];
//
////        while (true) {
////            [runLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
////        }
//    }
//}
//
//+ (NSThread *)networkRequestThread {
//    static NSThread *_networkRequestThread = nil;
//    static dispatch_once_t oncePredicate;
//    dispatch_once(&oncePredicate, ^{
//        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(startRunloop) object:nil];
//        [_networkRequestThread start];
//    });
//
//    return _networkRequestThread;
//}

- (void)main {
    NSLog(@"main ...");
}

- (void)start {
    // operation queue 会启动一个线程
    // 但是这个没什么问题， 因为 operation 会重用线程，且有最大线程数
    // 不必担心 开启线程 的 资源消耗
//    [self performSelector:@selector(operateStart) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
    NSLog(@"start ..");
    [self setFinished:YES];
}

- (void)setCompletionBlock:(void (^)(void))completionBlock {
    if (completionBlock) {
        completionBlock();
    }
    NSLog(@"commmmmm");
}

- (void)setIsF:(BOOL)isF {
    [self willChangeValueForKey:@"isFinished"];
    
    [self didChangeValueForKey:@"isFinished"];
}

- (void)operateStart {
    NSLog(@"....");
//    BOOL isRepeat = YES;
//    if (self.target && self.selector) {
//        if (self.timeInterval == 0) {
//            isRepeat = NO;
//        }
//        NSTimer *timer = [NSTimer timerWithTimeInterval:self.timeInterval
//                                                 target:self.target
//                                               selector:self.selector
//                                               userInfo:nil
//                                                repeats:isRepeat];
//        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//        [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
//    }
}

- (void)operateCancel {
//    timer
}

- (void)dealloc {
    NSLog(@"dealloc operation...");
}

@end
