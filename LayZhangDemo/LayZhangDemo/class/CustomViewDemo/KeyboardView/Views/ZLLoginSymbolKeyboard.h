//
//  ZLLoginSymbolKeyboard.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLKeyboardTool.h"

@interface ZLLoginSymbolKeyboard : UIView {
    id <ZLCustomKeyboardDelegate> _delegate;
}

@property (nonatomic, retain) id<ZLCustomKeyboardDelegate> delegate;

@end
