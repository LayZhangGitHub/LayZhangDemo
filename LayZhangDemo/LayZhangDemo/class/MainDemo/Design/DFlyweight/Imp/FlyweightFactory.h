//
//  FlyweightFactory.h
//  LayZhangDemo
//
//  Created by Lay on 2019/6/5.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAbsFlyweight.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlyweightFactory : NSObject

+ (DAbsFlyweight *)getFlyweight:(NSString *)outter;

@end

NS_ASSUME_NONNULL_END
