//
//  NSProxyDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/27.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "NSProxyDemoController.h"
#import "MiddleProxy.h"

@interface NSProxyDemoController ()

@end

@implementation NSProxyDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"ProxyDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self nsproxyDemo];
}


/**
 NSProxy 主要是 消息转发
 **/
- (void)nsproxyDemo {
    MiddleProxy *proxy = [MiddleProxy getMiddleProxy];
    [proxy provideAWithName:@"product A"];
    [proxy provideBWithName:@"product B"];
    
    // 若方法名相同， 则调用的是后注册的。
    [proxy performSelector:@selector(test)];
    
    
    //    ProductAProvider *provider = [[ProductAProvider alloc] init];
    //    ProductBProvider *providerB = [[ProductBProvider alloc] init];
    ////    [provider performSelector:@selector(test)];
    //    NSMethodSignature *signature = [providerB methodSignatureForSelector:@selector(test)];
    //    NSInvocation *invoke = [NSInvocation invocationWithMethodSignature:signature];
    //
    //    invoke.selector = @selector(test);
    //    [invoke invokeWithTarget:provider];
}


@end
