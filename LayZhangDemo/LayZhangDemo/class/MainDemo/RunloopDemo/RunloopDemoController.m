//
//  RunloopDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/10/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "RunloopDemoController.h"

@interface RunloopDemoController ()<NSPortDelegate>

@property (nonatomic, strong) NSMutableArray *mThreads;

@end

static NSPort *machPort;

@implementation RunloopDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithTitle:@"RunloopDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    
//    [self threadDemo];
    
    UIButton *stopButton = [[UIButton alloc] init];
    stopButton.frame = CGRectMake(30, 130, 180, 40);
    [stopButton setBackgroundColor:[UIColor blackColor]];
    [stopButton setTitle:@"StopRunloop" forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(stopRunloop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopButton];
    
}


- (void)stopRunloop {
    for (int i = 0; i < self.mThreads.count; i++) {
        [self performSelector:@selector(cancel)
                     onThread:self.mThreads[i]
                   withObject:@"stopRunloop"
                waitUntilDone:NO];
    }
    [self.mThreads removeAllObjects];
}

- (void)cancel {
    NSLog(@"cancel %@", [NSThread currentThread]);
    
    // 不再续
    NSMutableDictionary* threadDict = [[NSThread currentThread] threadDictionary];
    [threadDict setValue:[NSNumber numberWithBool:YES] forKey:@"ThreadShouldExitNow"];
    
    CFRunLoopStop(CFRunLoopGetCurrent());
    
    NSThread *thread = [NSThread currentThread];
    [thread cancel];
    //    [NSThread exit];
    
}

- (void)threadDemo {
    
    // create thread
    self.mThreads = [NSMutableArray new];
    
    for (int i = 0; i < 1; i++) {
        @autoreleasepool {
            NSThread *thread = [[NSThread alloc] initWithTarget:[self class] selector:@selector(networkRequestThreadEntryPoint:) object:[NSString stringWithFormat:@"%dName", i]];
            [thread start];
            //            [self performSelector:@selector(addObserver)
            //                         onThread:thread
            //                       withObject:@"23132"
            //                    waitUntilDone:NO];
            [self.mThreads addObject: thread];
        }
    }
}

- (void)myThreadMainMethod:(id)object {
    NSLog(@"%@", object);
    NSLog(@"thread %@", [NSThread currentThread]);
    
}

+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:object];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        //    NSLog(@"%@", runLoop);
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"....");
        }];
        [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
        
//        if (!machPort) {
//            machPort = [NSMachPort port];
//        }
//
        
//        [runLoop addPort:machPort forMode:NSDefaultRunLoopMode];

        BOOL exitNow = NO;

        NSMutableDictionary* threadDict = [[NSThread currentThread] threadDictionary];
        [threadDict setValue:[NSNumber numberWithBool:exitNow] forKey:@"ThreadShouldExitNow"];

        while (!exitNow) {
            NSLog(@"while begin");
            [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            exitNow = [[threadDict valueForKey:@"ThreadShouldExitNow"] boolValue];
            NSLog(@"while end");
        }

        NSLog(@"ending .........");
    }
}

- (void)addObserver {
    @autoreleasepool {
        CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            
            switch (activity) {
                case kCFRunLoopEntry:
                    NSLog(@"即将进入runloop");
                    break;
                case kCFRunLoopBeforeTimers:
                    NSLog(@"即将处理 Timer");
                    break;
                case kCFRunLoopBeforeSources:
                    NSLog(@"即将处理 Sources");
                    break;
                case kCFRunLoopBeforeWaiting:
                    NSLog(@"即将进入休眠");
                    break;
                case kCFRunLoopAfterWaiting:
                    NSLog(@"从休眠中唤醒loop");
                    break;
                case kCFRunLoopExit:
                    NSLog(@"即将退出runloop");
                    break;
                    
                default:
                    break;
            }
            
        });
        
        CFRunLoopAddObserver(CFRunLoopGetCurrent(),observer,kCFRunLoopDefaultMode);
        
        // 释放runloop
        CFRelease(observer);
    }
}

//- (void)handlePortMessage:(NSPortMessage *)message {
//    NSLog(@"....... %@", message);
//}

//+ (NSThread *)networkRequestThread {
//    static NSThread *_networkRequestThread = nil;
//    static dispatch_once_t oncePredicate;
//    dispatch_once(&oncePredicate, ^{
//        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
//        [_networkRequestThread start];
//    });
//    return _networkRequestThread;
//}


@end
