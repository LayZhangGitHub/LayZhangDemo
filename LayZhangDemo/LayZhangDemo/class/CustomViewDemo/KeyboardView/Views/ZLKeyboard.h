//
//  ZLKeyboard.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LoginNumberKeyboard 0
#define LoginSymbolKeyboard 1
#define TradeNumberKeyboard 2

@class ZLKeyboard;

@protocol ZLKeyboardDelegate <NSObject>

- (void)keyboard:(ZLKeyboard *)keyboard didClickTextButton:(UIButton *)textBtn string:(NSMutableString *)string;;
- (void)keyboard:(ZLKeyboard *)keyboard didClickDeleteButton:(UIButton *)deleteBtn string:(NSMutableString *)string;
- (void)keyboardReturn;

@end

@interface ZLKeyboard : UIView{
    id<ZLKeyboardDelegate> _delegate;
}

//- (id)initWithInputString:(NSString *)inputString type:(int)type;
- (id)initWithType:(int)type;

- (void)resetInputString:(NSString *)inputString;

- (void)setIsNeedPwd:(Boolean)isNeedPwd;
@property (nonatomic, retain) id<ZLKeyboardDelegate> delegate;

@property (nonatomic, retain) UITextField *currentTextField;

@end
