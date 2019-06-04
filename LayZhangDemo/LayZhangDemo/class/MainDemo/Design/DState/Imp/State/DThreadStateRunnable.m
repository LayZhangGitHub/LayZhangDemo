//
//  DThreadStateRunnable.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "DThreadStateRunnable.h"
#import "DThreadStateRunning.h"
#import "DThreadContext.h"

@implementation DThreadStateRunnable

- (void)initState
{
    self.state = DThreadStateTypeRunnable;
    ZLFuncLog(@"状态runable");
}

- (void)getCPU:(DThreadContext *)context
{
    if (!context) {
        return;
    }
    if (self.state != DThreadStateTypeRunnable) {
        [self failedReason:@"getCPU failed"];
        return;
    }
    context.threadState = [DThreadStateRunning new];
}

@end
