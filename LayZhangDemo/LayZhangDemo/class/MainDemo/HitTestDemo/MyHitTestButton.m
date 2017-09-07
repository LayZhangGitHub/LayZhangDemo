//
//  MyHitTestButton.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/6.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MyHitTestButton.h"

@implementation MyHitTestButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        UIView *view = [super hitTest:point withEvent:event];
        if (view) {
            NSLog(@"hit button %@", view);
            return view;
        }
        for (UIView *subView in self.subviews.reverseObjectEnumerator) {
            CGPoint subPoint = [self convertPoint:point toView:subView];
            view = [super hitTest:subPoint withEvent:event];
            if (view) {
                NSLog(@"hit button %@", view);
                return view;
            }
        }
    }
    
    
    return nil;
}

@end
