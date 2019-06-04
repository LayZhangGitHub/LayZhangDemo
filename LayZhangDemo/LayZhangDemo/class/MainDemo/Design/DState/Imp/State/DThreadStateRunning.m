//
//  DThreadStateRunning.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "DThreadStateRunning.h"
#import "DThreadStateBlocked.h"
#import "DThreadStateDead.h"
#import "DThreadContext.h"

@implementation DThreadStateRunning

- (void)initState
{
    self.state = DThreadStateTypeRunning;
    ZLFuncLog(@"状态running");
}

- (void)suspend:(DThreadContext *)context
{
    if (!context) {
        return;
    }
    if (self.state != DThreadStateTypeRunning) {
        [self failedReason:@"suspend failed"];
        return;
    }
    context.threadState = [DThreadStateBlocked new];
}

- (void)stop:(DThreadContext *)context
{
    if (!context) {
        return;
    }
    if (self.state != DThreadStateTypeRunning) {
        [self failedReason:@"stop failed"];
        return;
    }
    context.threadState = [DThreadStateDead new];
}

@end
