//
//  ConCommandB.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "ConCommandB.h"

@implementation ConCommandB

- (void)execute
{
    if (self.receiver) {
        [self.receiver doActionB];
    }
}

@end
