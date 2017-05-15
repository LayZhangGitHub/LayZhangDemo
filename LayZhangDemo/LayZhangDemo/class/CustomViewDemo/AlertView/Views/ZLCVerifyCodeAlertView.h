//
//  ZLVerifyCodeAlertView.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLVerifyDelegate.h"

// ** 代码布局 ** //
@interface ZLCVerifyCodeAlertView : UIView

@property (nonatomic, weak) id<ZLVerifyDelegate> delegate;

+ (instancetype)sharedSendVerifyCodeView;

+ (void)show;
+ (void)dismiss;

@end
