//
//  AbstractPollingOperation.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/12/7.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractPollingOperation : NSOperation

//@property (nonatomic, strong) NSTimer *pollingTimer;
//@property (nonatomic, assign) NSTimeInterval timeInterval;// 间隔时间
//@property (nonatomic, assign) NSInteger maxTimes;// 最大次数

//- (void)finish;

@property (nonatomic, strong) NSTimer *pollingTimer;

@end
