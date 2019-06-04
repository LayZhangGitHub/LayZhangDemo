//
//  ConCommandB.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "ConCommandB.h"

@interface ConCommandB()
@property (nonatomic, strong) CReceiver *receiver;
@end

@implementation ConCommandB

- (instancetype)initWithReceiver:(CReceiver *)receiver
{
    if (self = [super init]) {
        _receiver = receiver;
    }
    return self;
}

- (void)execute
{
    if (self.receiver) {
        [self.receiver doActionB];
    }
}

@end
