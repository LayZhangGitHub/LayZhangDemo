//
//  WeakProxy.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MyWeakProxy.h"

@interface MyWeakProxy()

/**
 消息转发的 对象
 */
@property (nonatomic, weak) id target;

@end

@implementation MyWeakProxy

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target {
    return [[MyWeakProxy alloc] initWithTarget:target];
}

#pragma mark - private
// 消息 重定向
- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}

#pragma mark - over write
// 若消息 已经 正确 重定向， 下面转发 消息不会执行
- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_target respondsToSelector:aSelector];
}

#pragma mark - NSObject protocol

- (BOOL)isEqual:(id)object {
    return [_target isEqual:object];
}

- (NSUInteger)hash {
    return [_target hash];
}

- (Class)superclass {
    return [_target superclass];
}

- (Class)class {
    return [_target class];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_target isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_target conformsToProtocol:aProtocol];
}

- (BOOL)isProxy {
    return YES;
}

- (NSString *)description {
    return [_target description];
}

- (NSString *)debugDescription {
    return [_target debugDescription];
}


@end
