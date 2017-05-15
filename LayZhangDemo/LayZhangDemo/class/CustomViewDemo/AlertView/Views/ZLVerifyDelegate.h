//
//  ZLVerifyDelegate.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/12.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ZLVerifyDelegate <NSObject>

- (void)didSelectAlert:(UIView *)alertView isOK:(Boolean)isOK;

@end
