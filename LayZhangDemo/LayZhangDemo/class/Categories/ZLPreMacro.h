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
#import "UIView+QuickNew.h"
#import "UIImage+ZLEX.h"
#import "CALayer+ZLEX.h"
#import "UIButton+ZLEX.h"
#import "NSString+ZLEX.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Masonry.h"
#import "YYModel.h"
#import "NSObject+Runtime.h"

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

#pragma mark - log
#ifdef DEBUG
#define AllLog(format, ...) \
NSLog((@"[文件名:%s]" "[函数名:%s]" "[行号:%d] Log:" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define FileLog(format, ...) \
NSLog((@"[文件名:%s] Log:" format), __FILE__, ##__VA_ARGS__);
#define FuncLog(format, ...) \
NSLog((@"[函数名:%s] Log:" format), __FUNCTION__, ##__VA_ARGS__);
#define FuncLineLog(format, ...) \
NSLog((@"[函数名:%s]" "[行号:%d] Log:" format), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define AllLog(...);
#define FileLog(...);
#define FuncLog(...);
#endif

//NSLog((@"[文件名:%s]" "[函数名:%s]" "[行号:%d]" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);


//
//NSString * logStr = [NSString stringWithFormat:@"%s, %d", __FILE__, __LINE__]; \
//NSLog(__VA_ARGS__, @"%s", __func__);

#pragma mark - notification
#define DefaultNotificationCenter [NSNotificationCenter defaultCenter]
#define TimerCellDeallocNotification @"TimerCellDeallocNotification"

#endif /* ZLPreMacro_h */
