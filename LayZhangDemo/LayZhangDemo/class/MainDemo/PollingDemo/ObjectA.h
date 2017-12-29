//
//  ObjectA.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/12/7.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObjectProtocol<NSObject>
@required
- (void)hello;
@end

@interface ObjectA : NSObject<ObjectProtocol>

@end
