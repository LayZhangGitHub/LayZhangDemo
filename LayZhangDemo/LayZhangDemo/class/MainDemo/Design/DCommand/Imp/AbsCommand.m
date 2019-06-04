//
//  AbsCommand.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "AbsCommand.h"

@implementation AbsCommand

- (instancetype)initWithReceiver:(CReceiver *)receiver
{
    if (self = [super init]) {
        _receiver = receiver;
    }
    return self;
}

- (void)execute
{
    // imp subclass
}

@end
