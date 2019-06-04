//
//  DThreadStateBlocked.h
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "DAbsThreadState.h"

NS_ASSUME_NONNULL_BEGIN

@interface DThreadStateBlocked : DAbsThreadState

- (void)resume:(DThreadContext *)context;

@end

NS_ASSUME_NONNULL_END
