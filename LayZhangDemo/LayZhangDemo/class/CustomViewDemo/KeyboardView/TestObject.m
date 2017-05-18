//
//  TestObject.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/16.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject

+ (void)test {
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    NSLog(@"%@",[[mArray copy] class]);
    NSLog(@"%@",[[mArray mutableCopy] class]);
}

@end
