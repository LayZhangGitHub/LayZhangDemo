//
//  WeakProxy.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 可用于 解除 循环引用
 **/
@interface MyWeakProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;

@end
