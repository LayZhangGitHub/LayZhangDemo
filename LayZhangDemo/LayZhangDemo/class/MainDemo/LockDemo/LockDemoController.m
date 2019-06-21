//
//  LockDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/11/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "LockDemoController.h"
#import <pthread/pthread.h>

#import "Car.h"

@interface LockDemoController (){
    pthread_mutex_t _mutex;
}
@property (nonatomic, strong) NSMutableDictionary *mArray;

@property (nonatomic, strong) dispatch_queue_t queue;

@end



@implementation LockDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // nslock demo
    [self createNavBarWithTitle:@"" withLeft:[UIImage imageNamed:@"icon_back"]];
    self.queue = dispatch_queue_create("mmm.com.queue", DISPATCH_QUEUE_SERIAL);
//    Car *cara = [Car new];
//    cara.name= @"a";
//    Car *carb = [Car new];
//    carb.name= @"a";
//    NSArray *a = @[@{@"te":@"va"}, @{@"ta":@"vt"}, @{@"a":cara}];
//    NSArray *b = @[@{@"te":@"va"}, @{@"ta":@"vt"}, @{@"a":carb}];
//
//    NSLog(@"%p", a);
//    NSLog(@"%p", b);
//    if ([a isEqualToArray:b]) {
//        NSLog(@"e");
//    } else {
//        NSLog(@"b");
//    }
    
        [self sampleNSLockDemo];
    
    
    // semaphore demo
//    [self sampleSemaphoreDemo];
}

- (void)sampleNSLockDemo {
    self.mArray = @{}.mutableCopy;
    dispatch_async(self.queue, ^{

        static int  count = 0;
        while (true) {
//                self.mArray = @[@"1",@"2", @"3"].mutableCopy;
//            if (self.mArray.count == 10) {
//                [self.mArray removeAllObjects];
//            }
//            [self.mArray addObject:@"1"];
//            self.mArray = @{@"key2":@"value2"}.mutableCopy;
            @autoreleasepool {
//                self.mArray = @{@"key1":@"a"}.mutableCopy;
//                [self.mArray addObject:@"key2"];
//                NSLog(@"%p", self.mArray);
                [self.mArray setObject:@{@"value":@"a"} forKey:@"key1"];
                count++;
            }
//            [self.mArray setObject:@{@"obj2":@"obj2"} forKey:@"key2"];
//            [self.mArray setObject:@{@"obj3":@"obj3"} forKey:@"key3"];
//            for (NSString *key in self.mArray.allKeys) {
//                [self.mArray removeObjectForKey:@"key2"];
//            }
        }

    });
    
    dispatch_async(self.queue, ^{
        while (true) {
            NSLog(@"%@", [self.mArray objectForKey:@"key1"]);
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
