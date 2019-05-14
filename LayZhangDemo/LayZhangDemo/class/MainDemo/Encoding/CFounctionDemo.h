//
//  CFounctionDemo.h
//  LayZhangDemo
//
//  Created by Lay on 2019/4/30.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFounctionDemo : NSObject

+ (id)objectWithCValue:(void *)src forType:(const char *)typeString;

@end

NS_ASSUME_NONNULL_END
