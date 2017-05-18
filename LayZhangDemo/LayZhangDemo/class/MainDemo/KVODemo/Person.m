//
//  Person.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/18.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"name"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

@end
