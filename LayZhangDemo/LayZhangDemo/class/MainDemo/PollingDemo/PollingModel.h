//
//  PollingModel.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/6/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

//成功时的block
typedef void(^FinishedBlock)(id object);

//失败时的block
typedef void(^FailuredBlock)(id object);

@interface PollingModel : NSObject

+ (void)requestFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//- (void)testA;
//+ (void)testB;
@end
