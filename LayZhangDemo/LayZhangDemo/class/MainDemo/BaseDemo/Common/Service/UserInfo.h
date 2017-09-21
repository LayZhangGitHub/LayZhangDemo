//
//  UserInfo.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/21.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, strong) NSDictionary *extraProperties;

@end
