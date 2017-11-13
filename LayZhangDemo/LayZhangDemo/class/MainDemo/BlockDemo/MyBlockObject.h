//
//  MyBlockObject.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/10/25.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBlockObject : NSObject

@property (nonatomic, strong) void(^mmBlock)(void);

- (void)doSome:(void(^)(void))mBlock;

@end

