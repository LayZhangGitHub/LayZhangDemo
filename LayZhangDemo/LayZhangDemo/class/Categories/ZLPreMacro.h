//
//  ZLPreMacro.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#ifndef ZLPreMacro_h
#define ZLPreMacro_h

#import "UIView+ZLEX.h"
#import "UIImage+ZLEX.h"
#import "CALayer+ZLEX.h"
#import "UIButton+ZLEX.h"

#pragma mark - screen
#define Screen [UIScreen mainScreen]
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENBOUNDS [UIScreen mainScreen].bounds
#define SCREENSCALE [UIScreen mainScreen].scale

#pragma mark - color
#define ZLWhiteColor    [UIColor whiteColor]
#define ZLClearColor    [UIColor clearColor]
#define ZLBlackColor    [UIColor blackColor]
#define ZLRedColor      [UIColor redColor]
#define ZLColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#pragma mark - font
#define ZLBoldFont(x)   [UIFont boldSystemFontOfSize:(x)]
#define ZLNormalFont(x) [UIFont systemFontOfSize:(x)]
#define ZLItalicFont(x) [UIFont italicSystemFontOfSize:(x)]

#pragma mark - scale
#define SCALE (SCREENWIDTH/750.0)

#pragma mark - notification
#define DefaultNotificationCenter [NSNotificationCenter defaultCenter]

#define TimerCellDeallocNotification @"TimerCellDeallocNotification"

#endif /* ZLPreMacro_h */
