//
//  RunloopDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/10/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "RunloopDemoController.h"



@interface RunloopDemoController ()

@end

@implementation RunloopDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [RunloopDemoController networkRequestThread];
    
    RunloopDemoController * a = [[RunloopDemoController alloc] init];
    [a print];
}

- (void)print {
    
    NSLog(@"%@", NSStringFromClass([self superclass]));
    NSLog(@"%@", NSStringFromClass([super class]));
    NSLog(@"%@", [super class]);
}

+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    [[NSThread currentThread] setName:@"mmThread"];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    [runLoop run];
}

+ (NSThread *)networkRequestThread {
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });
    return _networkRequestThread;
}

- (void)start {
    [self performSelector:@selector(test)
                 onThread:[[self class] networkRequestThread]
               withObject:nil
            waitUntilDone:NO
                    modes:@[NSRunLoopCommonModes]];
}

- (void)test {
    NSLog(@"test ....");
}

@end
