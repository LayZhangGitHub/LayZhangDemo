//
//  PollingTask.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/12/4.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PollingTask.h"

@interface PollingTask()

@end

@implementation PollingTask

- (NSUInteger)hash {
    long v1 = (long)((void *)_selector);
    long v2 = (long)_target;
    return v1 ^ v2;
}

- (BOOL)isEqual:(id)object {
    if (self == object) return YES;
    if (![object isMemberOfClass:self.class]) return NO;
    PollingTask *other = object;
    return other.selector == _selector && other.target == _target;
}

@end
