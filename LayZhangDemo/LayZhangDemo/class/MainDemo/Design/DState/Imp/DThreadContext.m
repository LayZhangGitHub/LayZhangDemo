//
//  DThreadContext.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "DThreadContext.h"
#import "DThreadStateNew.h"
#import "DThreadStateRunnable.h"
#import "DThreadStateRunning.h"
#import "DThreadStateBlocked.h"
#import "DThreadStateDead.h"

@implementation DThreadContext

- (instancetype)init
{
    if (self = [super init]) {
        self.threadState = [DThreadStateNew new];
    }
    return self;
}

- (void)start
{
    if (![self.threadState isKindOfClass:[DThreadStateNew class]]) {
        [self.threadState failedReason:@"start failed"];
        return;
    }
    [((DThreadStateNew *)self.threadState) start:self];
}

- (void)getCPU
{
    if (![self.threadState isKindOfClass:[DThreadStateRunnable class]]) {
        [self.threadState failedReason:@"getCPU failed"];
        return;
    }
    [((DThreadStateRunnable *)self.threadState) getCPU:self];
}

- (void)suspend
{
    if (![self.threadState isKindOfClass:[DThreadStateRunning class]]) {
        [self.threadState failedReason:@"suspend failed"];
        return;
    }
    [((DThreadStateRunning *)self.threadState) suspend:self];
}

- (void)resume
{
    if (![self.threadState isKindOfClass:[DThreadStateBlocked class]]) {
        [self.threadState failedReason:@"resume failed"];
        return;
    }
    [((DThreadStateBlocked *)self.threadState) resume:self];
}

- (void)stop
{
    if (![self.threadState isKindOfClass:[DThreadStateRunning class]]) {
        [self.threadState failedReason:@"stop failed"];
        return;
    }
    [((DThreadStateRunning *)self.threadState) stop:self];
}

@end
