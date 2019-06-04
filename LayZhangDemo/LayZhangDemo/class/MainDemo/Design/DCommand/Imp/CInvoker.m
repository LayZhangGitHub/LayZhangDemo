//
//  CInvoker.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "CInvoker.h"

@implementation CInvoker

- (void)doCommand
{
    if (self.command) {
        [self.command execute];
    }
}

@end
