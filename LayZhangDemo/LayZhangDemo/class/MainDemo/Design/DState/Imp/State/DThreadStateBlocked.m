//
//  DThreadStateBlocked.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "DThreadStateBlocked.h"
#import "DThreadStateRunnable.h"
#import "DThreadContext.h"

@implementation DThreadStateBlocked

- (void)initState
{
    self.state = DThreadStateTypeBlocked;
    ZLFuncLog(@"状态blocked");
}

- (void)resume:(DThreadContext *)context
{
    if (!context) {
        return;
    }
    if (self.state != DThreadStateTypeBlocked) {
        [self failedReason:@"blocked failed"];
        return;
    }
    context.threadState = [DThreadStateRunnable new];
}

@end
