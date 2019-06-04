//
//  DThreadContext.h
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAbsThreadState.h"

NS_ASSUME_NONNULL_BEGIN

@interface DThreadContext : NSObject

@property (nonatomic, strong) DAbsThreadState *threadState;

- (void)start;
- (void)getCPU;
- (void)suspend;
- (void)resume;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
