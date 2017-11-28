//
//  ZLOperation.m
//  NSOperationQueueDemo
//
//  Created by LayZhang on 2015/5/2.
//  Copyright © 2015年 Zhanglei. All rights reserved.
//

#import "ZLOperation.h"

@interface ZLOperation()

@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;

@end

@implementation ZLOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

//start: 所有并行的 Operations 都必须重写这个方法，然后在你想要执行的线程中手动调用这个方法。注意：任何时候都不能调用父类的start方法。
//main: 在start方法中调用，但是注意要定义独立的自动释放池与别的线程区分开。
//isExecuting: 是否执行中，需要实现KVO通知机制。
//isFinished: 是否已完成，需要实现KVO通知机制。
//isConcurrent: 该方法现在已经由isAsynchronous方法代替，并且 NSOperationQueue 也已经忽略这个方法的值。
//isAsynchronous: 该方法默认返回 NO ，表示非并发执行。并发执行需要自定义并且返回 YES。后面会根据这个返回值来决定是否并发。

//- (void)start {
////    [super start];
//    self.executing = YES;
//    NSLog(@"start...");
//    [self main];
//}

- (void)main {
    
    NSLog(@"main begin");
    sleep(10);
    @try {
        // 必须为自定义的 operation 提供 autorelease pool，因为 operation 完成后需要销毁。
        @autoreleasepool {
            // 提供一个变量标识，来表示需要执行的操作是否完成了，当然，没开始执行之前，为NO
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception %@", e);
    }
    NSLog(@"main end");
//    finished = YES;
    self.finished = YES;
}


- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    
    [self didChangeValueForKey:@"isExecuting"];
}

//- (void)completeOperation {
//    [self willChangeValueForKey:@"isFinished"];
//    [self willChangeValueForKey:@"isExecuting"];
//
//    executing = NO;
//    finished = YES;
//
//    [self didChangeValueForKey:@"isExecuting"];
//    [self didChangeValueForKey:@"isFinished"];
//}

// 已经弃用，使用 isAsynchronous 代替

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isAsynchronous {
    return YES;
}

@end
