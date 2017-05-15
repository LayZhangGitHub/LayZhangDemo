//
//  ZLKeyboardTool.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class ZLTradeNumberKeyboard, ZLLoginNumberKeyboard, ZLLoginSymbolKeyboard;

@protocol ZLCustomKeyboardDelegate <NSObject>

//@optional
//- (void)tradeNumberKeyboard:(ZLTradeNumberKeyboard *)letter didClickButton:(UIButton *)button;
//- (void)loginNumberKeyboard:(ZLLoginNumberKeyboard *)number didClickButton:(UIButton *)button;
//- (void)customKeyboardDidClickDeleteButton:(UIButton *)deleteBtn;

- (void)keyboard:(id)keyboard didClickNormalButton:(UIButton *)button;
- (void)keyboard:(id)keyboard didClickDeleteButton:(UIButton *)button;

@end

@interface ZLKeyboardTool : UIView

#pragma mark - 添加放大效果按钮
+ (UIButton *)setupEnlargeButtonsWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage titleColor:(UIColor *)color;

#pragma mark - 添加基础按钮
+ (UIButton *)setupBasicButtonsWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage titleColor:(UIColor *)color;

#pragma mark - 添加功能按钮
+ (UIButton *)setupFunctionButtonWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage titleColor:(UIColor *)color;

@end
