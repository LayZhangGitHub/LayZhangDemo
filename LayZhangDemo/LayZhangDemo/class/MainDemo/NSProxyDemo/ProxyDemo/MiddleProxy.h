//
//  MiddleProxy.h
//  NSProxyDemo
//
//  Created by LayZhang on 2017/5/4.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ProductAProvider.h"
#import "ProductBProvider.h"

@interface MiddleProxy : NSProxy<productAProtocol, productBProtocol>

+ (instancetype)getMiddleProxy;

@end
