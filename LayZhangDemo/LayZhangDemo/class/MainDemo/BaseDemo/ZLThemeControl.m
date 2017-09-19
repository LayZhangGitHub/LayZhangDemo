//
//  ZLThemeControl.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLThemeControl.h"

static ZLThemeValue themeType = ThemeType;

@implementation ZLThemeControl

+ (instancetype)shareThemeInstance {
    static ZLThemeControl *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZLThemeControl alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        switch (themeType) {
            case ZLThemeValueType01:
                [self initThemeType01];
                break;
                
            case ZLThemeValueType02:
                [self initThemeType02];
                break;
            case ZLThemeValueType03:
                [self initThemeType03];
                break;
            default:
                break;
        }
    }
    return self;
}

- (void)initThemeType01 {
    _backgroundColor = ZLRedColor;
    _navigationBackgroundColor = ZLRedColor;
    _titleColor = ZLBlackColor;
    _navigationButtonColor = ZLBlackColor;
    _navigationBottomBorderColor = ZLBlackColor;
    _tabBarBackgroundColor = ZLBlackColor;
    _tabBarTopBorderColor = ZLBlackColor;
}

- (void)initThemeType02 {
    _backgroundColor = ZLRedColor;
    _navigationBackgroundColor = ZLRedColor;
    _titleColor = ZLBlackColor;
    _navigationButtonColor = ZLBlackColor;
    _navigationBottomBorderColor = ZLBlackColor;
    _tabBarBackgroundColor = ZLBlackColor;
    _tabBarTopBorderColor = ZLBlackColor;
}

- (void)initThemeType03 {
    _backgroundColor = ZLRedColor;
    _navigationBackgroundColor = ZLRedColor;
    _titleColor = ZLBlackColor;
    _navigationButtonColor = ZLBlackColor;
    _navigationBottomBorderColor = ZLBlackColor;
    _tabBarBackgroundColor = ZLBlackColor;
    _tabBarTopBorderColor = ZLBlackColor;
}

@end
