//
//  AQuestion04Controller.m
//  LayZhangDemo
//
//  Created by WorkLay on 2018/11/22.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "AQuestion04Controller.h"

// 异步 转同步
@interface AQuestion04Controller ()

@end

@implementation AQuestion04Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sync];
}

- (void)sync {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block int number = 0;
    dispatch_async(queue, ^{
        // 追加任务1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        
        number = 100;
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore---end,number = %zd",number);
}

@end
