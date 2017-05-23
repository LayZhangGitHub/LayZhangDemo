//
//  UIControl+Log.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Log)

- (void)addLogTarget:(id)target
              action:(SEL)action
    forControlEvents:(UIControlEvents)controlEvents;

@end
