//
//  DAbsThreadState.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "DAbsThreadState.h"

@implementation DAbsThreadState

- (instancetype)init
{
    if (self = [super init]) {
        [self initState];
    }
    return self;
}

- (void)initState
{
    // imp subclass
}

- (void)failedReason:(NSString *)reason
{
    ZLFuncLog(@"%@", reason);
}

@end
