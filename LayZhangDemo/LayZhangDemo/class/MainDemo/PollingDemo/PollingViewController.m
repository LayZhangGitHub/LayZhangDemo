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

@interface PollingViewController ()

@property (nonatomic, assign) NSUInteger requestTime;
@property (atomic, strong) NSArray *mArray;

@end

@implementation PollingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"PollingDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
//    [self polling];
    [self doSometing];
    
}

- (void)doSometing {
    _mArray = @[];
    
    while (true) {
        sleep(0.9);
        for (int i = 0; i < 100; i++) {
//            @autoreleasepool {
//                NSObject *a = [NSObject new];
//                NSLog(@"%d log, %@", i, a);
//            }
        }
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (1) {
//            self.mArray = [[NSArray alloc] initWithObjects:@1, @2, @3, nil];
             objc_setAssociatedObject(self, _cmd, @[@1, @2, @3], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (1) {
//            NSLog(@"%@", self.mArray);
//            NSLog(@"%@", objc_getAssociatedObject(self, _cmd));
        }
    });
    
//    [[PollingManager getInstance] doPolling];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"main thread %@", [NSThread currentThread]);
//    });
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"global thread %@", [NSThread currentThread]);
//    });
//
//    dispatch_queue_t myQueue = dispatch_queue_create(<#const char * _Nullable label#>, <#dispatch_queue_attr_t  _Nullable attr#>)
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"global thread %@", [NSThread currentThread]);
//    });
    
//    dispatch_queue_t queue = dispatch_queue_create("com.lai111.www", DISPATCH_QUEUE_CONCURRENT);
//
//    for (int i = 0; i< 1000;i++){
//        // 10个异步
//        dispatch_async(queue, ^{
//            sleep(1);
//            NSLog(@"%@--%d",[NSThread currentThread], i);
//        });
//    }
    
//    dispatch_group_async(<#dispatch_group_t  _Nonnull group#>, <#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"sync - %@", [NSThread currentThread]);
//        });
//    });
//
//
//
//    dispatch_queue_t serialQueue = dispatch_queue_create("com.lai.www", DISPATCH_QUEUE_SERIAL);
//    NSLog(@"1 %@", [NSThread currentThread]);
//    dispatch_sync(serialQueue, ^{
//        NSLog(@"2 %@", [NSThread currentThread]);
//        dispatch_sync(serialQueue, ^{
//            NSLog(@"3 %@", [NSThread currentThread]);
//        });
//        NSLog(@"4 %@", [NSThread currentThread]);
//    });

////    NSLog(@"5 %@", [NSThread currentThread]);
//
//    dispatch_async(serialQueue, ^{
//        // NSLog(@"1");
//        sleep(3);
//        NSLog(@"%@--",[NSThread currentThread]);
//        NSLog(@"1");
//    });
//    dispatch_sync(serialQueue, ^{
//
//        sleep(1);
//        NSLog(@"%@--",[NSThread currentThread]);
//        NSLog(@"2");
//
//    });
//    dispatch_async(serialQueue, ^{
//        NSLog(@"%@--",[NSThread currentThread]);
//        NSLog(@"3");
//    });
//    dispatch_sync(serialQueue, ^{
//
//        sleep(5);
//        NSLog(@"%@--",[NSThread currentThread]);
//        NSLog(@"4");
//    });
//
//    dispatch_async(serialQueue, ^{
//        NSLog(@"%@--",[NSThread currentThread]);
//        NSLog(@"5");
//    });
    
//    NSArray *array = @[@"1", @"2", @"3", @"4", @"5", @"6"];
//    dispatch_queue_t queue11 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue11, ^{
//
//        dispatch_apply([array count], queue11, ^(size_t index){
//            [self doSomethingIntensiveWith:[array objectAtIndex:index]];
//        });
//    });
////    [self doSomethingWith:array];
//    NSLog(@"1231223123");
}

- (void)doSomethingIntensiveWith:(NSString *)a {
    NSLog(@"beigin %@", a);
    sleep(6);
    NSLog(@"%@", a);
}

- (void)dealloc {
    NSLog(@"Polling Viewcontroller dealloc");
}

@end
