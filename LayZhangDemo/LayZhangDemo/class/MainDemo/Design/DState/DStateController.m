//
//  DStateController.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "DStateController.h"
#import "DAbsThreadState.h"
#import "DThreadContext.h"

@implementation DStateController

- (void)viewDidLoad {
    [super viewDidLoad];
    DThreadContext *context = [DThreadContext new];
    [context start];
    [context getCPU];
    [context suspend];
    [context resume];
    [context getCPU];
    [context getCPU];
    [context stop];
}

@end
