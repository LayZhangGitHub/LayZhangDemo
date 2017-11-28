//
//  ReactModel.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/11/28.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ReactModel.h"

@implementation ReactModel

- (instancetype)init {
    if (self = [super init]) {
        @weakify(self);
        [RACObserve(self, name) subscribeNext:^(NSString* x) {
            @strongify(self);
            NSLog(@"你动了");
        }];
    }
    return self;
}

@end
