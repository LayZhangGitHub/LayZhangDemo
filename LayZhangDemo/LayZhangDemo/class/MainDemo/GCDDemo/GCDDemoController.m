//
//  GCDDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/12/1.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "GCDDemoController.h"

@interface GCDDemoController ()

@end

@implementation GCDDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self mainthreadDeadLockDemo];
    [self threadAsyncDemo];
}

- (void)mainthreadDeadLockDemo {
    /**
     主线程中 同步操作， 相当于主线程 等待主线程 死锁
     **/
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2");
//    });
//    NSLog(@"3");
    
    /**
     在非主线程 同步调用主线程 可以避免
     **/
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    });
}

- (void)threadAsyncDemo {
    NSLog(@"1");
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"2");
    });
    NSLog(@"3");
}

@end
