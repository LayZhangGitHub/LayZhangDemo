//
//  AQuestion03Controller.m
//  LayZhangDemo
//
//  Created by WorkLay on 2018/11/22.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "AQuestion03Controller.h"

@interface AQuestion03Controller () {
    dispatch_semaphore_t _semaphore;
    __block int number;
}

@end

@implementation AQuestion03Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    _semaphore = dispatch_semaphore_create(1);
    number = 0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self writeSync];
    });
    
}

- (void)writeSync {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    dispatch_async(queue, ^{
        // 追加任务1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        number = 100;
        dispatch_semaphore_signal(_semaphore);
    });
    
    NSLog(@"semaphore---end,number = %d",number);
}

@end
