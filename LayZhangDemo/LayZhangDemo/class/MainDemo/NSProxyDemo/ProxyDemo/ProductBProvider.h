//
//  ProductBProvider.h
//  NSProxyDemo
//
//  Created by LayZhang on 2017/5/4.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol productBProtocol

- (void)provideBWithName:(NSString *)name;

@end

@interface ProductBProvider : NSObject

@end
