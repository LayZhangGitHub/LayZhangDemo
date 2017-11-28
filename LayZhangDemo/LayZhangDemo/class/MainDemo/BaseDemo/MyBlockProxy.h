//
//  MyBlockProxy.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/11/23.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBlockProxy : NSProxy

+ (instancetype)proxyWithBlock:(void (^)(void))mblock;

@end
