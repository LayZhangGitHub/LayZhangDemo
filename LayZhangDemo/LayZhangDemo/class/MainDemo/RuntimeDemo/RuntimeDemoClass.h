//
//  RuntimeDemoClass.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/25.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RuntimeDemoClass : NSObject

@property (nonatomic, strong) NSString *property01;
@property (nonatomic, strong) NSString *property02;

+ (void)metaMethodWithArgument:(NSString *)argument;

- (void)publicTestMethod1;
- (void)publicTestMethod2;
- (void)publicUnImpMethod3; // 未实现的方法

@end
