//
//  DThreadStateDead.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "DThreadStateDead.h"

@implementation DThreadStateDead

- (void)initState
{
    self.state = DThreadStateTypeDead;
    ZLFuncLog(@"状态dead");
}

@end
