//
//  ProductBProvider.m
//  NSProxyDemo
//
//  Created by LayZhang on 2017/5/4.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ProductBProvider.h"

@implementation ProductBProvider


- (void)provideBWithName:(NSString *)name {
    NSLog(@"provideB product:%@", name);
}

- (void)test {
    NSLog(@"this is b");
}



@end
