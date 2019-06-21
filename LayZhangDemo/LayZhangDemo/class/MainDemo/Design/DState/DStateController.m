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

static int count = 10;
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
    
    while (count) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:[[NSClassFromString(@"DStateController") alloc] init]
                                                 animated:YES];
            count--;
        });
        
    }
    
}

@end
