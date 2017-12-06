//
//  NSOperationQueueViewController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/15.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "NSOperationQueueViewController.h"
#import "ZLOperation.h"

@interface NSOperationQueueViewController ()

@end

@implementation NSOperationQueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"NSOperationQueueDemo"
                       withLeft:[UIImage imageNamed:@"icon_back"]];
    [self operationTest];

}

- (void)operationTest {
    // operation invo
//    NSInvocationOperation * invo1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testOperation) object:nil];
//    NSInvocationOperation * invo2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testOOO) object:nil];
//    NSInvocationOperation * invo3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testOperation) object:nil];
//    NSInvocationOperation * invo4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testOperation) object:nil];
//
//
//    // 添加依赖 执行有 先后顺序
//    [invo1 addDependency:invo2];
    
//    NSOperationQueue *queue = [NSOperationQueue new];
//    queue.maxConcurrentOperationCount = 2;
//
//    for (int i = 0; i < 10; i++) {
//         NSInvocationOperation * inv = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testOperation) object:nil];
//        [queue addOperation:inv];
//    }
    
    
//    ZLOperation *operation01 = [[ZLOperation alloc] init];
//    operation01.completionBlock = ^{
//        NSLog(@"operation01 completion");
//    };
//    ZLOperation *operation02 = [[ZLOperation alloc] init];
//    operation02.completionBlock = ^{
//        NSLog(@"operation02 completion");
//    };
//    ZLOperation *operation03 = [[ZLOperation alloc] init];
//    operation03.completionBlock = ^{
//        NSLog(@"operation03 completion");
//    };
//// 阻塞运行
//    [operation01 start];
//    [operation02 start];
//    [operation03 start];
//    [queue addOperation:operation01];
//    [queue addOperation:operation02];
//    [queue addOperation:operation03];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"02 cancel");
//        [operation02 cancel];
//    });

    
    
    // operationblock
//    NSBlockOperation * blockOperation = [NSBlockOperation
//                                         blockOperationWithBlock:^{
//                                             NSLog(@"begin 1在第%@个线程",[NSThread currentThread]);
//                                             sleep(5);
//                                             NSLog(@"end 1在第%@个线程",[NSThread currentThread]);
//                                         }];
//    [blockOperation addExecutionBlock:^{
//        NSLog(@"begin 2在第%@个线程",[NSThread currentThread]);
//        sleep(4);
//        NSLog(@"end 2在第%@个线程",[NSThread currentThread]);
//    }];
//    [blockOperation addExecutionBlock:^{
//        NSLog(@"begin 3在第%@个线程",[NSThread currentThread]);
//        sleep(5);
//        NSLog(@"end 3在第%@个线程",[NSThread currentThread]);
//    }];
//    [blockOperation addExecutionBlock:^{
//        NSLog(@"begin 4在第%@个线程",[NSThread currentThread]);
//        sleep(5);
//        NSLog(@"end 4在第%@个线程",[NSThread currentThread]);
//    }];
//    [blockOperation addExecutionBlock:^{
//        NSLog(@"begin 5在第%@个线程",[NSThread currentThread]);
//        sleep(5);
//        NSLog(@"end 5在第%@个线程",[NSThread currentThread]);
//    }];
//    [queue addOperation:blockOperation];
    
    
    
    
//    NSOperationQueue *queue = [NSOperationQueue new];
//    queue.maxConcurrentOperationCount = 1;
//    NSLog(@"count is %ld", (long)queue.maxConcurrentOperationCount);
//    [queue addOperation:invo1];
//    NSLog(@"count is %ld", (long)queue.maxConcurrentOperationCount);
////    [queue addOperation:invo2];
//    NSLog(@"count is %ld", (long)queue.maxConcurrentOperationCount);
//    [queue addOperation:blockOperation];
//    NSLog(@"count is %ld", (long)queue.maxConcurrentOperationCount);
//    [queue addOperation:operation];
//    NSLog(@"count is %ld", (long)queue.maxConcurrentOperationCount);
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [queue addOperation:invo2];
        
//    });
    
}

- (void)testOperation {
    
    NSLog(@"---- biegin operator ----");
    sleep(100);
    NSLog(@"---- end operator ----");
    NSLog(@"001 我在第%@个线程",[NSThread currentThread]);
}

- (void)testOOO {
    NSLog(@"002 我在第%@个线程",[NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
