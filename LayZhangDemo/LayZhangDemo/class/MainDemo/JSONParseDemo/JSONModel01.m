//
//  JSONModel01.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/23.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "JSONModel01.h"

@implementation JSONModel01

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

//+ (JSONKeyMapper *)keyMapper {
//    return [[JSONKeyMapper alloc] initWithDictionary:@{
//                                                       @"mModel.name": @"name"
//                                                       }];
//}

@end
