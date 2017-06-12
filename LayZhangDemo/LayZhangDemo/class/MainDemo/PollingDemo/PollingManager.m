//
//  PollingManager.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/6/12.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PollingManager.h"
#import "PollingModel.h"

#define REQUESTMAXTIME 10

@interface PollingManager()

@property (nonatomic, assign) NSUInteger requestTime;
@property (nonatomic, assign) Boolean isRequesting;

@end

@implementation PollingManager

+ (instancetype)getInstance {
    static PollingManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [PollingManager new];
    });
    return instance;
}

- (void)doPolling {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        if (!self.isRequesting) {
            self.requestTime = 0;
            self.isRequesting = true;
            [self request];
        }
        
    });
}


- (void)request {
    
    if (self.requestTime >= REQUESTMAXTIME) {
        NSLog(@"请求 失败 超过 10 次");
        self.isRequesting = false;
        return;
    }
    self.requestTime++;
    //网络请求
    [PollingModel requestFinishedBlock:^(id object) {
        if ([object isEqualToString:@"timeout"]) {
            [self requestAndPrint];
        } else {
            NSLog(@"success");
            self.isRequesting = false;
        }
    } failuredBlock:^(id object) {
        [self requestAndPrint];
    }];
}

- (void)requestAndPrint{
    NSLog(@"第%lu次请求 timeout", (unsigned long)self.requestTime);
    NSLog(@"%@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:3];
    [self request];
}

@end
