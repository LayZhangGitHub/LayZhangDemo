//
//  PollingAOperation.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/12/7.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PollingAOperation.h"

@interface PollingAOperation()

@property (nonatomic,assign) NSInteger currentTimes;

@end

@implementation PollingAOperation

- (instancetype)init {
    if (self = [super init]) {
        _currentTimes = 0;
        self.completionBlock = ^{};
    }
    return self;
}

- (void)pollingTask {
    self.pollingTimer = [NSTimer timerWithTimeInterval:3
                                                target:self
                                              selector:@selector(polling)
                                              userInfo:nil
                                               repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.pollingTimer forMode:NSRunLoopCommonModes];
}

- (void)polling {
    self.currentTimes++;
    NSLog(@"polling ...");
    if (self.currentTimes == 4) {        
        [self cancel];
    }
//    [netrequest success: [cancel]
//                failure:];
}

@end
