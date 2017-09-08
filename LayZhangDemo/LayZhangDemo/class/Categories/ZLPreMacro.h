//
//  ZLPreMacro.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#ifndef ZLPreMacro_h
#define ZLPreMacro_h

/** import category or other third part **/
#pragma mark - import file
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
#import "NSArray+YYAdd.h"

/** screen util**/
#pragma mark - screen
#define Screen [UIScreen mainScreen]
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENBOUNDS [UIScreen mainScreen].bounds
#define SCREENSCALE [UIScreen mainScreen].scale
#define LINE_WIDTH   1.f / [UIScreen mainScreen].scale
#define STATUSBAR_HEIGHT            20.f
#define NAVBAR_HEIGHT               (44.f + STATUSBAR_HEIGHT)
#define NAVBAR_CONTAINER_HEIGHT     44.f

/** color **/
#pragma mark - color
#define ZLWhiteColor    [UIColor whiteColor]
#define ZLClearColor    [UIColor clearColor]
#define ZLBlackColor    [UIColor blackColor]
#define ZLRedColor      [UIColor redColor]



#define ZLRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define ZLRGB(r,g,b)    ZLRGBA(r,g,b,1)
#define ZLGray(g)       ZLRGB(g,g,g)

#define ZLHEXA(hex,a)       [UIColor colorWithHexString:hex alpha:a]
#define ZLHEX(hex)          CHEXA(hex,1)

/** font **/
#pragma mark - font
#define ZLBoldFont(x)   [UIFont boldSystemFontOfSize:(x)]
#define ZLNormalFont(x) [UIFont systemFontOfSize:(x)]
#define ZLItalicFont(x) [UIFont italicSystemFontOfSize:(x)]

#pragma mark - scale
#define SCALE (SCREENWIDTH/750.0)

/** string **/
#define IsEmptyString(str)      (!str || [str.trim isEqualToString : @""])

/** log **/
#pragma mark - log
#ifdef DEBUG
#define ZLLog(...) NSLog(__VA_ARGS__)
#define ZLAllLog(format, ...) \
NSLog((@"[文件名:%s]" "[函数名:%s]" "[行号:%d] Log:" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define ZLFileLog(format, ...) \
NSLog((@"[文件名:%s] Log:" format), __FILE__, ##__VA_ARGS__);
#define ZLFuncLog(format, ...) \
NSLog((@"[函数名:%s] Log:" format), __FUNCTION__, ##__VA_ARGS__);
#define ZLFuncLineLog(format, ...) \
NSLog((@"[函数名:%s]" "[行号:%d] Log:" format), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define ZLLog(...);
#define ZLAllLog(...);
#define ZLFileLog(...);
#define ZLFuncLog(...);
#endif

#define LogGRect(rect)       ZLLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define LogGSize(size)       ZLLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define LogGPoint(point)     ZLLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

/** notification **/
#pragma mark - notification
#define DefaultNotificationCenter [NSNotificationCenter defaultCenter]
#define TimerCellDeallocNotification @"TimerCellDeallocNotification"

//weakSelf & strongSelf
#define weakSelf( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__attribute__((objc_ownership(weak))) __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#define strongSelf( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__attribute__((objc_ownership(strong))) __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

/** iOS version **/
#pragma mark - version
#define SYSTEM_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]
#define IS_IOS10                    (SYSTEM_VERSION >= 10)
#define IS_IOS9                     (SYSTEM_VERSION >= 9)
#define IS_IOS8                     (SYSTEM_VERSION >= 8)
#define IS_IOS7                     (SYSTEM_VERSION >= 7)
#define IS_IPHONE4                  (SCREEN_HEIGHT < 568)
#define IS_IPHONE5                  (SCREEN_HEIGHT == 568)
#define IS_IPHONE6                  (SCREEN_HEIGHT == 667)
#define IS_IPHONE6Plus              (SCREEN_HEIGHT == 736)

#endif /* ZLPreMacro_h */
