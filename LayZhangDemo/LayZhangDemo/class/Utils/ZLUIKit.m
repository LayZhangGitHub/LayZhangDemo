//
//  ZLUIKit.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/22.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLUIKit.h"

@implementation ZLUIKit

#pragma mark - UILabel


+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                       fontSize:(CGFloat)fontSize {
    return [self labelWithTextColor:textColor
                               text:@""
                           fontSize:fontSize];
}

+ (UILabel *)labelWithText:(NSString *)text
                  fontSize:(CGFloat)fontSize {
    return [self labelWithTextColor:ZLClearColor
                        text:text
                    fontSize:fontSize];
}


+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                           text:(NSString *)text
                       fontSize:(CGFloat)fontSize {
    return [self labelWithTextColor:textColor
                      numberOfLines:1
                               text:text
                           fontSize:fontSize];
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                  numberOfLines:(NSInteger)numberOfLines
                           text:(NSString *)text
                       fontSize:(CGFloat)fontSize {
    return [self labelWithBackgroundColor:ZLClearColor
                                textColor:textColor
                            textAlignment:NSTextAlignmentLeft
                            numberOfLines:numberOfLines
                                     text:text
                                 fontSize:fontSize];
}

+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor
                            textColor:(UIColor *)textColor
                        textAlignment:(NSTextAlignment)textAlignment
                        numberOfLines:(NSInteger)numberOfLines
                                 text:(NSString *)text
                             fontSize:(CGFloat)fontSize {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = backgroundColor;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    label.text = text;
    label.font = ZLNormalFont(fontSize);
    return label;
}


@end
