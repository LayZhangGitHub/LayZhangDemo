//
//  DAbsThreadState.h
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DThreadContext;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DThreadStateType) {
    DThreadStateTypeUnknown = 0,
    DThreadStateTypeNew,
    DThreadStateTypeRunnable,
    DThreadStateTypeRunning,
    DThreadStateTypeBlocked,
    DThreadStateTypeDead,
};

@interface DAbsThreadState : NSObject

@property (nonatomic, assign) DThreadStateType state;

- (void)initState;
- (void)failedReason:(NSString *)reason;

@end

NS_ASSUME_NONNULL_END
