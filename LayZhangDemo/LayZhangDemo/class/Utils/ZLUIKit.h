//
//  ZLUIKit.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/22.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLUIKit : NSObject

#pragma mark - UILabel
+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                       fontSize:(CGFloat)fontSize;

+ (UILabel *)labelWithText:(NSString *)text
                  fontSize:(CGFloat)fontSize;

+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                           text:(NSString *)text
                       fontSize:(CGFloat)fontSize;

+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                  numberOfLines:(NSInteger)numberOfLines
                           text:(NSString *)text
                       fontSize:(CGFloat)fontSize;

+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor
                            textColor:(UIColor *)textColor
                        textAlignment:(NSTextAlignment)textAlignment
                        numberOfLines:(NSInteger)numberOfLines
                                 text:(NSString *)text
                             fontSize:(CGFloat)fontSize;


@end
