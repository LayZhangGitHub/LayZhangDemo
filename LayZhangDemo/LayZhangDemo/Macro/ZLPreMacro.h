//
//  ZLPreMacro.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#ifndef ZLPreMacro_h
#define ZLPreMacro_h

#pragma mark - screen
#define ZLScreen [UIScreen mainScreen]
#define ZLScreenW [UIScreen mainScreen].bounds.size.width
#define ZLScreenH [UIScreen mainScreen].bounds.size.height
#define ZLScreenBounds [UIScreen mainScreen].bounds
#define ZLScreenScale [UIScreen mainScreen].scale

#pragma mark - color
#define ZLWhiteColor [UIColor whiteColor]
#define ZLClearColor [UIColor clearColor]
#define ZLBlackColor [UIColor blackColor]
#define FDColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#pragma mark - font
#define ZLFontBold(x)   [UIFont boldSystemFontOfSize:(x)]
#define ZLFontNormal(x) [UIFont systemFontOfSize:(x)]
#define ZLFontItalic(x) [UIFont italicSystemFontOfSize:(x)]




#endif /* ZLPreMacro_h */
