//
//  NSObject+Runtime.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

// 类和 对象 都可以获取，目前只写一份

// 获取类名
+ (NSString *)getClassName;
//- (NSString *)getClassName;

// 获取 变量列表
+ (NSArray *)getIvarList;
//- (NSArray *)getIvarList;

// 获取属性列表
+ (NSArray *)getPropertyList;

// 获取 实例对象方法
+ (NSArray *)getMethodList;

// 获取 类方法
+ (NSArray *)getMetaMethodList;

// 获取 协议列表
+ (NSArray *)getProtocolList;

// 添加对象方法
+ (void)addMethod:(SEL)methodSel fromClass:(Class)fromClass;
+ (void)addMethod:(Method)method;

// 添加类方法
+ (void)addMetaMethod:(SEL)methodSel fromClass:(Class)fromClass;
+ (void)addMetaMethod:(Method)method;
+ (void)addMethod:(Class)class method:(SEL)methodSel method:(SEL)methodSelImpl;

// 方法交换
+ (void)methodChange:(SEL)method1 method:(SEL)method2;
+ (void)metaMethodChange:(SEL)method1 method:(SEL)method2;
@end
