//
//  ConChainB.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "ConChainB.h"

@implementation ConChainB

- (void)handleRequest:(nonnull NSString *)request
{
    if (![request isEqualToString:NSStringFromClass(self.class)]) {
        [super handleRequest:request];
        return;
    }
    
    ZLFuncLog(@"ChainB");
}

@end
