//
//  ZLKeyboardView.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/15.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLKeyboardView;

@protocol ZLKeyboardDelegate

- (void)keyboardView:(ZLKeyboardView *)keyboard
  didClickTextButton:(UIButton *)textBtn
              string:(NSString *)string;

- (void)keyboardView:(ZLKeyboardView *)keyboard
didClickDeleteButton:(UIButton *)deleteBtn
              string:(NSString *)string;

- (void)keyboardReturn;

@end


@interface ZLKeyboardView : UIView

@property (nonatomic, weak) id<ZLKeyboardDelegate> delegate;


@end
