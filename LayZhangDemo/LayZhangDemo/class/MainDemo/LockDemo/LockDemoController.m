//
//  LockDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/11/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "LockDemoController.h"
#import <pthread/pthread.h>

@interface LockDemoController (){
    pthread_mutex_t _mutex;
}
@property (nonatomic, copy) NSArray *mArray;

@end



@implementation LockDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // nslock demo
    [self sampleNSLockDemo];
    
    
    // semaphore demo
    //    [self sampleSemaphoreDemo];
}

- (void)sampleNSLockDemo {
    self.mArray = @[@"1",@"2", @"3"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        while (true) {
            @autoreleasepool {
                self.mArray = @[@"1",@"2", @"3",@"2", @"3",@"2", @"3",@"2", @"3",@"2", @"3",@"2", @"3"];
            }
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (true) {
            @autoreleasepool {
            NSLog(@"%@", self.mArray);
            }
        }
    });
}

- (void)sampleSemaphoreDemo {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    for (int i= 0; i < 10; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
            NSLog(@"run task 1");
            sleep(4);
            NSLog(@"complete task 1");
            
            dispatch_semaphore_signal(semaphore);
        });
    }
}

- (void)samplePthreadMutexDemo {
    
    pthread_mutex_init(&_mutex, NULL);
    //    pthread_mutex_init(&mutex, NULL);
    
    for (int i= 0; i < 10; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            pthread_mutex_lock(&_mutex);
            
            NSLog(@"run task 1");
            sleep(4);
            NSLog(@"complete task 1");
            
            pthread_mutex_unlock(&_mutex);
        });
    }
    
    
}


@end
