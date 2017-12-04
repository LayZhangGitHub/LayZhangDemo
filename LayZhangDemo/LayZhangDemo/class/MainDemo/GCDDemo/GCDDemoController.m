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
    
    [self groupDemo];
}

- (void)groupDemo {
    dispatch_queue_t dispatchQueue = dispatch_queue_create("ted.queue.next1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_group_t dispatchGroup = dispatch_group_create();
//    dispatch_group_enter(dispatchGroup);
//    dispatch_group_leave(dispatchGroup);
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        sleep(5);
        NSLog(@"任务一完成");
    });
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        NSLog(@"notify：任务都完成了");
    });
    for (int i = 0; i < 100; i++) {
     // 并不会无限的开启新的线程， 当线程多到一定 数量时， 也会等待前面的线程结束，重用线程
        dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
            sleep(2);
            NSLog(@"current %@", [NSThread currentThread]);
            NSLog(@"任务二完成");
        });
    }
    
    
    
    dispatch_group_async(dispatchGroup, globalQueue, ^{
        
        sleep(10);
        NSLog(@"任务三完成");
       
    });
    
    dispatch_async(globalQueue, ^{
        NSLog(@"begin wait");
        dispatch_group_wait(dispatchGroup, dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC));
        NSLog(@"end wait");
    });
    
   
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"beigin");
//
//        dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
//            sleep(5);
//            NSLog(@"任务一完成");
//        });
//        dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
//
//            sleep(6);
//            NSLog(@"任务二完成");
//        });
//
//        dispatch_group_async(dispatchGroup, globalQueue, ^{
//
//            sleep(10);
//            NSLog(@"任务三完成");
//        });
//    });
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
