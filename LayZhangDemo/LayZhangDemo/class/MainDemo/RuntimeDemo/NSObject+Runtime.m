//
//  NSObject+Runtime.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "NSObject+Runtime.h"

@implementation NSObject (Runtime)

+ (BOOL)isMetaClass {
    return class_isMetaClass(object_getClass(self));
}

- (BOOL)isMetaClass {
    return class_isMetaClass(object_getClass(self));
}

+ (NSString *)getClassName {
    const char *className = class_getName(self.self);
    return [NSString stringWithUTF8String:className];
}

+ (NSArray *)getIvarList {
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self.self, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dic[@"type"] = [NSString stringWithUTF8String: ivarType];       // 数据类型
        dic[@"ivarName"] = [NSString stringWithUTF8String: ivarName];   // 变量名称
        
        [mutableList addObject:dic];
    }
    free(ivarList);
    return [NSArray arrayWithArray:mutableList];
}

+ (NSArray *)getPropertyList {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(self.self, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        const char *propertyName = property_getName(propertyList[i]);
        [mutableList addObject:[NSString stringWithUTF8String: propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableList];

}

+ (NSArray *)getMethodList {
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(self.self, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}

+ (NSArray *)getMetaMethodList {
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(object_getClass(self.self), &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}

+ (NSArray *)getProtocolList {
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(self.self, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [mutableList addObject:[NSString stringWithUTF8String: protocolName]];
    }
    
    return [NSArray arrayWithArray:mutableList];
    return nil;
}

+ (void)addMethod:(SEL)methodSel fromClass:(Class)fromClass{
    Method method = class_getInstanceMethod(fromClass, methodSel);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(self, methodSel, methodIMP, types);
}

+ (void)addMethod:(Method)method {
    SEL methodSel = method_getName(method);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(self, methodSel, methodIMP, types);
}

+ (void)addMetaMethod:(SEL)methodSel fromClass:(Class)fromClass {
    Method method = class_getInstanceMethod(fromClass, methodSel);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(object_getClass(self), methodSel, methodIMP, types);
}

+ (void)addMetaMethod:(Method)method {
    SEL methodSel = method_getName(method);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(object_getClass(self), methodSel, methodIMP, types);
}

+ (void)addMethod:(Class)class method:(SEL)methodSel method:(SEL)methodSelImpl {
    Method method = class_getInstanceMethod(class, methodSelImpl);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(class, methodSel, methodIMP, types);
}

+ (void)methodChange:(SEL)method1 method:(SEL)method2 {
    Method firstMethod = class_getInstanceMethod(self.self, method1);
    Method secondMethod = class_getInstanceMethod(self.self, method2);
    method_exchangeImplementations(firstMethod, secondMethod);
}

+ (void)metaMethodChange:(SEL)method1 method:(SEL)method2 {
    Method firstMethod = class_getInstanceMethod(object_getClass(self.self), method1);
    Method secondMethod = class_getInstanceMethod(object_getClass(self.self), method2);
    method_exchangeImplementations(firstMethod, secondMethod);
}

@end
