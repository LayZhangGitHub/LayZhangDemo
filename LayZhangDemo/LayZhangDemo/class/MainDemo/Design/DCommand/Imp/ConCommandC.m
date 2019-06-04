//
//  ConCommandC.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "ConCommandC.h"

@implementation ConCommandC

- (void)execute
{
    if (self.receiver) {
        [self.receiver doActionC];
    }
}

@end
