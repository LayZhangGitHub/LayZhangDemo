//
//  ProductAProvider.m
//  NSProxyDemo
//
//  Created by LayZhang on 2017/5/4.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ProductAProvider.h"

@implementation ProductAProvider

- (void)provideAWithName:(NSString *)name {
    NSLog(@"provideA product:%@", name);
}

- (void)test {
    NSLog(@"test");
}

@end
