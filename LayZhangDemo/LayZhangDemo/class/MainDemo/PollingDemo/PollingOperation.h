//
//  PollingOperation.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/12/6.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PollingOperation : NSOperation

@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, assign) NSTimeInterval timeInterval;

@end
