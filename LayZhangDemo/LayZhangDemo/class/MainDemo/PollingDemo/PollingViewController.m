//
//  PollingViewController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/6/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PollingViewController.h"
#import "PollingModel.h"
#import "PollingManager.h"
#import "PollingTask.h"

#import "AFHTTPRequestOperationManager.h"

@interface PollingViewController ()

@property (nonatomic, assign) NSUInteger requestTime;
@property (nonatomic, strong) NSMutableDictionary *mDic;
@property (nonatomic, strong) NSArray *mArray;

@property (nonatomic, assign) BOOL *isEndPolling;

@end

@implementation PollingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"PollingDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self doPolling];
    //    [self doSometing];
    
    AFHTTPRequestOperationManager *manager01 = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperationManager *manager02 = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperationManager *manager03 = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"%@", manager01);
    NSLog(@"%@", manager02);
    NSLog(@"%@", manager03);
    
    
}

- (void)doPolling {
    
    PollingManager *manager = [[PollingManager alloc] init];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [[PollingManager getInstance] commit];
//        PollingTask *task = [PollingTask taskWithTarget:self selector:@selector(doReq)];
//        task.timeInteval = 4;
//        task.maxPollingTimes = 6;
//        task.pollingName = @"thread.polling.demo";
//        [manager commitPollingTask:task];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [[PollingManager getInstance] commit];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(12.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [[PollingManager getInstance] commit];
    });
    //    [NSThread detachNewThreadSelector:@selector(newThreadFun) toTarget:self withObject:nil];
}

- (void)doReq {
    [PollingModel requestFinishedBlock:^(id object) {
        NSLog(@"success");
    } failuredBlock:^(id object) {
        
    }];
}

//-(void)newThreadFun {
//    @autoreleasepool {
//        NSRunLoop * myRunLoop =[NSRunLoop currentRunLoop];
//
//        //        CFRunLoopObserverContext context = {0, CFBridgingRetain(self),NULL,NULL,NULL};
//        CFRunLoopObserverContext context = {0, (__bridge_retained void *)self, NULL, NULL, NULL};
//        CFRunLoopObserverRef observer
//        = CFRunLoopObserverCreate(kCFAllocatorDefault,
//                                  kCFRunLoopAllActivities,
//                                  true,
//                                  0, // 最低优先级
//                                  &myRunLoopObserver,
//                                  &context);//info
//        if (observer) {
//            CFRunLoopRef cfRunloop = [myRunLoop getCFRunLoop];
//            CFRunLoopAddObserver(cfRunloop, observer, kCFRunLoopDefaultMode);
//        }
//        //        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerprocess) userInfo:nil repeats:YES];
//        while (!self.isEndPolling) {
//            [myRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];
//        }
//    }
//}
//
//- (void)timerprocess {
//    NSLog(@".......");
//}
//
//void myRunLoopObserver(CFRunLoopObserverRef observer,CFRunLoopActivity activity,void* info) {
//    switch (activity) {
//        case kCFRunLoopEntry:
//            NSLog(@"run loop entry");
//            break;
//        case kCFRunLoopBeforeTimers:
//            NSLog(@"run loop before times");
//            break;
//        case kCFRunLoopBeforeSources:
//            NSLog(@"run loop before sources");
//            break;
//        case kCFRunLoopBeforeWaiting:
//            NSLog(@"run loop before waiting");
//            break;
//        case kCFRunLoopAfterWaiting:
//            NSLog(@"run loop after waiting");
//            break;
//        case kCFRunLoopExit:
//            NSLog(@"run loop exit");
//            break;
//        default:
//            break;
//    }
//}
//
//- (void)doSometing {
//
//
//
//    //    [[NSThread currentThread] setName:@"mMMMM"];
//    //    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//    //    [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
//    //    [runLoop run];
//
//    //    _mArray = @[];
//
//    //    while (true) {
//    //        sleep(0.9);
//    //        for (int i = 0; i < 100; i++) {
//    ////            @autoreleasepool {
//    ////                NSObject *a = [NSObject new];
//    ////                NSLog(@"%d log, %@", i, a);
//    ////            }
//    //        }
//    //    }
//
//    //    NSLog(@" thread3 %@", [NSThread currentThread]);
//    //    NSLog(@" thread3 %@", [NSThread currentThread]);
//    //
//    //    dispatch_queue_t queue = dispatch_queue_create("mTestQueueuu", DISPATCH_QUEUE_SERIAL);
//    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//    //
//    //        dispatch_async(queue, ^{
//    //            NSLog(@" thread3 %@", [NSThread currentThread]);
//    //        });
//    //
//    //
//    //    });
//    ////
//    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//    //        sleep(3);
//    //        dispatch_async(queue, ^{
//    //            NSLog(@" thread2 %@", [NSThread currentThread]);
//    //        });
//    //
//    //    });
//    //
//    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//    //        sleep(10);
//    //        dispatch_async(queue, ^{
//    //            NSLog(@" thread1 %@", [NSThread currentThread]);
//    //        });
//    //
//    //    });
//
//    //
//
//    //    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
//    //
//    //    dispatch_async(queue, ^{
//    //        while (1) {
//    //            self.mArray = [[NSArray alloc] initWithObjects:@1, @2, @3, nil];
//    ////             objc_setAssociatedObject(self, _cmd, @[@1, @2, @3], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    //        }
//    //    });
//    //
//    //    dispatch_async(queue, ^{
//    //        while (1) {
//    //            NSLog(@"%@", self.mArray);
//    ////            NSLog(@"%@", objc_getAssociatedObject(self, _cmd));
//    //        }
//    //    });
//
//    //    [[PollingManager getInstance] doPolling];
//
//    //    dispatch_async(dispatch_get_main_queue(), ^{
//    //        NSLog(@"main thread %@", [NSThread currentThread]);
//    //    });
//    //
//    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//    //        NSLog(@"global thread %@", [NSThread currentThread]);
//    //    });
//    //
//    //    dispatch_queue_t myQueue = dispatch_queue_create(<#const char * _Nullable label#>, <#dispatch_queue_attr_t  _Nullable attr#>)
//    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//    //        NSLog(@"global thread %@", [NSThread currentThread]);
//    //    });
//
//    //    dispatch_queue_t queue = dispatch_queue_create("com.lai111.www", DISPATCH_QUEUE_CONCURRENT);
//    //
//    //    for (int i = 0; i< 1000;i++){
//    //        // 10个异步
//    //        dispatch_async(queue, ^{
//    //            sleep(1);
//    //            NSLog(@"%@--%d",[NSThread currentThread], i);
//    //        });
//    //    }
//
//    //    dispatch_group_async(<#dispatch_group_t  _Nonnull group#>, <#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
//    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//    //        dispatch_sync(dispatch_get_main_queue(), ^{
//    //            NSLog(@"sync - %@", [NSThread currentThread]);
//    //        });
//    //    });
//    //
//    //
//    //
//    //    dispatch_queue_t serialQueue = dispatch_queue_create("com.lai.www", DISPATCH_QUEUE_SERIAL);
//    //    NSLog(@"1 %@", [NSThread currentThread]);
//    //    dispatch_sync(serialQueue, ^{
//    //        NSLog(@"2 %@", [NSThread currentThread]);
//    //        dispatch_sync(serialQueue, ^{
//    //            NSLog(@"3 %@", [NSThread currentThread]);
//    //        });
//    //        NSLog(@"4 %@", [NSThread currentThread]);
//    //    });
//
//    ////    NSLog(@"5 %@", [NSThread currentThread]);
//    //
//    //    dispatch_async(serialQueue, ^{
//    //        // NSLog(@"1");
//    //        sleep(3);
//    //        NSLog(@"%@--",[NSThread currentThread]);
//    //        NSLog(@"1");
//    //    });
//    //    dispatch_sync(serialQueue, ^{
//    //
//    //        sleep(1);
//    //        NSLog(@"%@--",[NSThread currentThread]);
//    //        NSLog(@"2");
//    //
//    //    });
//    //    dispatch_async(serialQueue, ^{
//    //        NSLog(@"%@--",[NSThread currentThread]);
//    //        NSLog(@"3");
//    //    });
//    //    dispatch_sync(serialQueue, ^{
//    //
//    //        sleep(5);
//    //        NSLog(@"%@--",[NSThread currentThread]);
//    //        NSLog(@"4");
//    //    });
//    //
//    //    dispatch_async(serialQueue, ^{
//    //        NSLog(@"%@--",[NSThread currentThread]);
//    //        NSLog(@"5");
//    //    });
//
//    //    NSArray *array = @[@"1", @"2", @"3", @"4", @"5", @"6"];
//    //    dispatch_queue_t queue11 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    //    dispatch_async(queue11, ^{
//    //
//    //        dispatch_apply([array count], queue11, ^(size_t index){
//    //            [self doSomethingIntensiveWith:[array objectAtIndex:index]];
//    //        });
//    //    });
//    ////    [self doSomethingWith:array];
//    //    NSLog(@"1231223123");
//}

//- (void)doSomethingIntensiveWith:(NSString *)a {
//    NSLog(@"beigin %@", a);
//    sleep(6);
//    NSLog(@"%@", a);
//}

- (void)dealloc {
    NSLog(@"Polling Viewcontroller dealloc");
}

@end
