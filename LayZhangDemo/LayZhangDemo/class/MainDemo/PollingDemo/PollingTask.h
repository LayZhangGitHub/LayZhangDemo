//
//  PollingTask.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/12/4.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PollingTask : NSObject

@property (nonatomic, strong) NSString *pollingName;
@property (nonatomic, assign) NSInteger maxPollingTimes;
@property (nonatomic, assign) NSTimeInterval timeInteval;
@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL selector;

@end
