//
//  UserInfoService.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoService : NSObject

+ (instancetype)shareUserInfo;

- (void)saveData;
- (void)clearData;

@end
