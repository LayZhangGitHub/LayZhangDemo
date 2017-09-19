//
//  BaseController.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLNavigationBar.h"
#import "ZLTabbarItem.h"


@class ZLTabbarController;

@interface BaseController : UIViewController

@property (nonatomic, strong) ZLNavigationBar *navigationBar;

@property (nonatomic, assign) BOOL needBlurEffect;
@property (nonatomic, assign) BOOL isHideNavigationBar;

/**
 tabbar
 */
@property (nonatomic, weak) ZLTabbarItem *tabbarItem;
@property (nonatomic, weak) ZLTabbarController *tabBarController;

/**
 通用的 页面 选择时的 附加参数
 */
@property (nonatomic, strong) NSDictionary *extraParams;

- (void)showNavigationBar;
- (void)hideNavigationBar;

@end
