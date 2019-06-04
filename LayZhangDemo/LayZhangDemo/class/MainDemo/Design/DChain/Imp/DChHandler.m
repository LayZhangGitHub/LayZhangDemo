//
//  DChHandler.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "DChHandler.h"

@implementation DChHandler

- (void)handleRequest:(nonnull NSString *)request
{
    if (self.nextHandler) {
        [self.nextHandler handleRequest:request];
        return;
    }
    
    NSLog(@"请求未被处理");
}

@end
