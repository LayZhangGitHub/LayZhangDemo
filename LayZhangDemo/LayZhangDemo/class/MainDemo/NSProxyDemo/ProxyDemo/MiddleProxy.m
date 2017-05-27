//
//  MiddleProxy.m
//  NSProxyDemo
//
//  Created by LayZhang on 2017/5/4.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MiddleProxy.h"


#import <objc/runtime.h>

@interface MiddleProxy() {
    ProductAProvider *_providerA;
    ProductBProvider *_providerB;
    NSMutableDictionary *_methodDic;
}

@end

@implementation MiddleProxy

+ (instancetype)getMiddleProxy {
    return [[MiddleProxy alloc] init];
}

- (instancetype)init {
    _providerA = [[ProductAProvider alloc] init];
    _providerB = [[ProductBProvider alloc] init];
    
    _methodDic = [[NSMutableDictionary alloc] init];
    
    [self registMethod:_providerA];
    [self registMethod:_providerB];
    
    return self;
}

#pragma mark - private

- (void)registMethod:(id)target {
    unsigned int methodNumber;
    
    Method *method_list = class_copyMethodList([target class], &methodNumber);
    
    // 因为使用 方法名 为Key
    // 所以 当方法名相同时， 调用后注册的
    for (int i = 0; i < methodNumber; i ++) {
        
        Method temp_method = method_list[i];
        SEL temp_sel = method_getName(temp_method);
        const char *temp_method_name = sel_getName(temp_sel);
        [_methodDic setObject:target forKey:[NSString stringWithUTF8String:temp_method_name]];
    }
    
    free(method_list);
}

#pragma mark - override
- (void)forwardInvocation:(NSInvocation *)invocation{
    //获取当前选择子
    SEL sel = invocation.selector;
    
    //获取选择子方法名
    NSString *methodName = NSStringFromSelector(sel);
    
    //在字典中查找对应的target
    id target = _methodDic[methodName];
    
    //检查target
    if (target && [target respondsToSelector:sel]) {
        [invocation invokeWithTarget:target];
    } else {
        [super forwardInvocation:invocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    //获取选择子方法名
    NSString *methodName = NSStringFromSelector(sel);
    
    //在字典中查找对应的target
    id target = _methodDic[methodName];
    
    //检查target
    if (target && [target respondsToSelector:sel]) {
        return [target methodSignatureForSelector:sel];
    } else {
        return [super methodSignatureForSelector:sel];
    }
    
    // target SEL --> methodSIgnature
    // [target methodSignatureForSelector:sel];
    
    // methodSignature --> invocation
    // [NSInvocation invocationWithMethodSignature:signature];
    
    // invocation target 执行
    // [invocation invokeWithTarget:target];
}

@end
