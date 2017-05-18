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
    NSInvocationOperation * invo1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testOperation) object:nil];
    NSInvocationOperation * invo2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testOperation) object:nil];
    
    // 添加依赖 执行有 先后顺序
    [invo1 addDependency:invo2];
    
    ZLOperation *operation = [[ZLOperation alloc] init];
    
    
    // operationblock
    NSBlockOperation * blockOperation = [NSBlockOperation
                                         blockOperationWithBlock:^{
                                             NSLog(@"1在第%@个线程",[NSThread currentThread]);
                                         }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"2在第%@个线程",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"3在第%@个线程",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"4在第%@个线程",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"5在第%@个线程",[NSThread currentThread]);
    }];
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:invo1];
    [queue addOperation:invo2];
    [queue addOperation:blockOperation];
    [queue addOperation:operation];
}

- (void)testOperation {
    NSLog(@"我在第%@个线程",[NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
