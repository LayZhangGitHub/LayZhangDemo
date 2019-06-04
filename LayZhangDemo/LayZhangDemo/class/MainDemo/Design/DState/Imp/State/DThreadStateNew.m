//
//  DThreadStateNew.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "DThreadStateNew.h"
#import "DThreadStateRunnable.h"
#import "DThreadContext.h"

@implementation DThreadStateNew

- (void)initState
{
    self.state = DThreadStateTypeNew;
    ZLFuncLog(@"状态new");
}

- (void)start:(DThreadContext *)context
{
    if (!context) {
        return;
    }
    if (self.state != DThreadStateTypeNew) {
        [self failedReason:@"start failed"];
        return;
    }
    context.threadState = [DThreadStateRunnable new];
}

@end
