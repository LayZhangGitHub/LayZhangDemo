//
//  MyHitTestView.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/6.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MyHitTestView.h"

@implementation MyHitTestView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"hit view : %@", self);
    return [super hitTest:point withEvent:event];
}

@end
