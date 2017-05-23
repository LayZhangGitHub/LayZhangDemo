//
//  UIControl+Log.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "UIControl+Log.h"
#import <objc/runtime.h>

static const void *logActionNameKey;
static const void *logTargetNameKey;

@implementation UIControl (Log)

- (void)setLogActionName:(NSString *)logActionName {
    objc_setAssociatedObject(self, &logActionNameKey, logActionName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)logActionName {
    return objc_getAssociatedObject(self, &logActionNameKey);
}

- (void)setLogTarget:(id)logTarget {
    // 不能相互引用
    objc_setAssociatedObject(self, &logTargetNameKey, logTarget, OBJC_ASSOCIATION_ASSIGN);
}

- (id)buttonTarget {
    return objc_getAssociatedObject(self, &logTargetNameKey);
}

- (void)addLogTarget:(id)target
              action:(SEL)action
    forControlEvents:(UIControlEvents)controlEvents {
    
    // 这样写 不好， 再次add 会有问题
    self.logTarget = target;
    self.logActionName = NSStringFromSelector(action);
    
    //    [super addTarget:target action:action forControlEvents:controlEvents];
    [self addTarget:self action:@selector(logAction:) forControlEvents:controlEvents];
    
}

- (void)logAction:(id)sender {
    NSLog(@"you can do log here");
    
    SEL selector = NSSelectorFromString(self.logActionName);
    [self.buttonTarget performSelector:selector withObject:sender];
}


@end
