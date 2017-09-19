//
//  ZLThemeControl.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ZLThemeCtrInstance [ZLThemeControl shareThemeInstance]

typedef NS_ENUM(NSInteger, ZLThemeValue) {
    ZLThemeValueType01      = 1,
    ZLThemeValueType02      = 2,
    ZLThemeValueType03      = 3,
};

@interface ZLThemeControl : NSObject

+ (instancetype)shareThemeInstance;

// 可根据 具体情况 添加修改
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *navigationBackgroundColor;
@property (nonatomic, strong) UIColor *navigationButtonColor;
@property (nonatomic, strong) UIColor *navigationBottomBorderColor;

@property (nonatomic, strong) UIColor *tabBarBackgroundColor;
@property (nonatomic, strong) UIColor *tabBarTopBorderColor;

@end
