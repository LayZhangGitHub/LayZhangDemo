//
//  KeyChainUtil.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/27.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainUtil : NSObject

+ (void)keyChainSaveDic:(NSDictionary *)dic;

+ (void)keyChainSave:(NSString *)string;

+ (NSString *)keyChainLoad;

+ (void)keyChainDelete;

@end
