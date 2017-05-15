//
//  ZLTradeNumberKeyboard.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLKeyboardTool.h"

@interface ZLTradeNumberKeyboard : UIView {
    id<ZLCustomKeyboardDelegate> _delegate;
}

@property (nonatomic, retain) id<ZLCustomKeyboardDelegate> delegate;

@end
