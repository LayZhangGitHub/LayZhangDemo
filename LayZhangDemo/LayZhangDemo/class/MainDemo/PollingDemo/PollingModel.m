//
//  PollingModel.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/6/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PollingModel.h"

#define requestInterval 2.0

@implementation PollingModel

+ (void)requestFinishedBlock:(FinishedBlock)finishedBlock
               failuredBlock:(FailuredBlock)failuredBlock {
    [NSThread sleepForTimeInterval:requestInterval];
    if (finishedBlock) {
        finishedBlock(@"timeout");
    }
}

@end
