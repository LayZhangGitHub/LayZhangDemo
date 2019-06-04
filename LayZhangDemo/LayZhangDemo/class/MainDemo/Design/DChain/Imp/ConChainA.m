//
//  ConChainA.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "ConChainA.h"

@implementation ConChainA

- (void)handleRequest:(nonnull NSString *)request
{
    if (![request isEqualToString:NSStringFromClass(self.class)]) {
        [super handleRequest:request];
        return;
    }
    
    ZLFuncLog(@"ChainA");
}

@end
