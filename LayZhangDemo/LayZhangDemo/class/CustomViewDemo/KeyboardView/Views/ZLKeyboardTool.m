//
//  ZLKeyboardTool.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ZLKeyboardTool.h"
#import "EnlargeButton.h"

@implementation ZLKeyboardTool

#pragma mark - 添加放大效果按钮
+ (UIButton *)setupEnlargeButtonsWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage titleColor:(UIColor *)color {
    //    EnlargeButton *button = [EnlargeButton buttonWithType:UIButtonTypeCustom];
    EnlargeButton *button = [[EnlargeButton alloc] init];
    //    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    //    button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    button.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:18.0f];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    //    [button setBackgroundImage:highImage forState:UIControlStateHighlighted];
    
    return button;
}

#pragma mark - 添加基础按钮
+ (UIButton *)setupBasicButtonsWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage titleColor:(UIColor *)color{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    //    button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    if ([title length] > 1) {
        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.0f];
    } else {
        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:16.0f];
    }
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    //    [button setBackgroundImage:highImage forState:UIControlStateHighlighted];
    
    return button;
}

#pragma mark - 添加功能按钮
+ (UIButton *)setupFunctionButtonWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage titleColor:(UIColor *)color{
    
    UIButton *otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    otherBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    if ([title length] > 1) {
        otherBtn.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:16.0f];
    } else {
        otherBtn.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.0f];
    }
    
    [otherBtn setTitle:title forState:UIControlStateNormal];
    [otherBtn setTitleColor:color forState:UIControlStateNormal];
    [otherBtn setBackgroundImage:image forState:UIControlStateNormal];
    //    [otherBtn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    
    return otherBtn;
}

@end
