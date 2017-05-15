//
//  ZLLoginNumberKeyboard.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLKeyboardTool.h"

@interface ZLLoginNumberKeyboard : UIView{
    id <ZLCustomKeyboardDelegate> _delegate;
}

@property Boolean isNeedPwd;
@property (nonatomic, retain) id<ZLCustomKeyboardDelegate> delegate;
- (void)relayout;
@end
