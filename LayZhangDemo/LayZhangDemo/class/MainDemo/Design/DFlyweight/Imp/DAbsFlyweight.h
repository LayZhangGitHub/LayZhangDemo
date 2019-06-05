//
//  DAbsFlyweight.h
//  LayZhangDemo
//
//  Created by Lay on 2019/6/5.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IFlywightProtocol <NSObject>

- (void)operate:(NSString *)outter;

@end

@interface DAbsFlyweight : NSObject

@property (nonatomic, strong) NSString *outter;

- (instancetype)initWithOutter:(NSString *)outter;

@end

NS_ASSUME_NONNULL_END
