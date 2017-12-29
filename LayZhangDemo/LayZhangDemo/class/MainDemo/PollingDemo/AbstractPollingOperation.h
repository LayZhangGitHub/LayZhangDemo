//
//  AbstractPollingOperation.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/12/7.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractPollingOperation : NSOperation

@property (nonatomic, strong) NSTimer *pollingTimer;

@end
