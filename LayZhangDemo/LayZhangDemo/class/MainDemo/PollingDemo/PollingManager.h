//
//  PollingManager.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/6/12.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PollingTask.h"

@interface PollingManager : NSObject

- (void)commitPollingTask:(PollingTask *)pollingTask;

@end
