//
//  FlyweightFactory.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/5.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "FlyweightFactory.h"
#import "ConFlywight.h"

static NSMutableDictionary *pool;

@interface FlyweightFactory()

@end

@implementation FlyweightFactory

+ (DAbsFlyweight *)getFlyweight:(NSString *)outter
{
    if (!pool) {
        pool = @{}.mutableCopy;
    }
    
    DAbsFlyweight *flyweight = [pool objectForKey:outter];
    if (!flyweight) {
        flyweight = [[ConFlywight alloc] initWithOutter:outter];
        [pool setObject:flyweight forKey:outter];
    }
    
    return flyweight;
}

@end
