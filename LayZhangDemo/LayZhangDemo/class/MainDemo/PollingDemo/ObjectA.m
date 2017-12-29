//
//  ObjectA.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/12/7.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ObjectA.h"

#define AbstractMethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]

@implementation ObjectA

- (instancetype)init {
    NSAssert(![self isMemberOfClass:[ObjectA class]], @"abstrct class should not imp");
    if (self = [super init]) {
        [self hello];
    }
    return self;
}

- (void)hello {
    if ([self isMemberOfClass:[ObjectA class]]) {
        AbstractMethodNotImplemented();
    }
}

@end
