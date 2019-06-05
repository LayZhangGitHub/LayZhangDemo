//
//  DAbsFlyweight.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/5.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "DAbsFlyweight.h"

@interface DAbsFlyweight()

@property (nonatomic, strong) NSString *inner;

@end

@implementation DAbsFlyweight

- (instancetype)initWithOutter:(NSString *)outter
{
    if (self = [super init]) {
        _outter = outter;
    }
    return self;
}

@end
