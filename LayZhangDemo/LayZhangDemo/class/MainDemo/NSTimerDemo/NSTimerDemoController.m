//
//  NSTimerDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/27.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "NSTimerDemoController.h"

@interface NSTimerDemoController ()

@end

@implementation NSTimerDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self timerDemo];
    //    [self observer];
    [self createNavBarWithTitle:@"timerDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [[self class] newThread];
    
    for (int i = 0; i < 100; i ++) {
        
        
        [self performSelector:@selector(myRun)
                     onThread:[[self class] newThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    //            [self performSelector:@selector(operationDidStart) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    
}

- (void)myRun {
    sleep(1);
    NSLog(@"%@", [NSThread currentThread]);
    NSLog(@"myrun");
}

+ (void)runThread {
    [[NSThread currentThread] setName:@"MyThread"];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [runLoop run];
}

+ (NSThread *)newThread {
    static NSThread *_myThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _myThread = [[NSThread alloc] initWithTarget:self selector:@selector(runThread) object:nil];
        [_myThread start];
    });
    return _myThread;
}


- (void)timerDemo {
    // 申明 并定义 timer
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    // NSDefaultRunLoopMode
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    // UITrackingRunLoopMode
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    // NSRunLoopCommonModes  Common Modes的模式
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    // 自动被加入到了RunLoop的NSDefaultRunLoopMode模式
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
}

- (void)observer {
    // 创建观察者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"监听到RunLoop发生改变---%zd",activity);
    });
    
    // 添加观察者到当前RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    // 释放observer，最后添加完需要释放掉
    CFRelease(observer);
}

- (void)run {
    NSLog(@"running...");
}

- (void)perform {
    //    线程间通信
    //    线程在运行过程中，可能需要与其它线程进行通信。我们可以使用 NSObject 中的一些方法：
    //    在应用程序主线程中做事情：
    //performSelectorOnMainThread:withObject:waitUntilDone:
    //performSelectorOnMainThread:withObject:waitUntilDone:modes:
    //
    //    在指定线程中做事情：
    //performSelector:onThread:withObject:waitUntilDone:
    //performSelector:onThread:withObject:waitUntilDone:modes:
    //
    //    waitUntilDone参数是个bool值，如果设置为NO,相当于异步执行，当前函数执行完，立即执行后面的语句。如果设置为YES,相当于同步执行，当前线程要等待Selector中的函数执行完后再执行。
    //
    //    在当前线程中做事情：
    //performSelector:withObject:afterDelay:
    //performSelector:withObject:afterDelay:inModes:
    //
    //    取消发送给当前线程的某个消息
    //cancelPreviousPerformRequestsWithTarget:
    //cancelPreviousPerformRequestsWithTarget:selector:object:
}



@end
