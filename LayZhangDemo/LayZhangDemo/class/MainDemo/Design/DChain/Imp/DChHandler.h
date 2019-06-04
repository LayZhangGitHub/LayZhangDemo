//
//  DChHandler.h
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IChainHandler <NSObject>

- (void)handleRequest:(NSString *)request;

@end

@interface DChHandler : NSObject<IChainHandler>

@property (nonatomic, strong) DChHandler *nextHandler;

@end

NS_ASSUME_NONNULL_END
