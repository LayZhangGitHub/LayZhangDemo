//
//  RuntimeDemoClass.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/25.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "RuntimeDemoClass.h"

@interface TempClass : NSObject

- (void)publicUnImpMethod3;

@end

@implementation TempClass

- (void)publicUnImpMethod3 {
    NSLog(@"temp class publicUnImpMethod3");
}

@end

@interface RuntimeDemoClass() {
    NSInteger _var1;
    int _var2;
    BOOL _var3;
    double _var4;
    float _var5;
//    NSMutableArray *privateProperty1; // privateProperty1覆盖
}

@property (nonatomic, strong) NSMutableArray *privateProperty1;
@property (nonatomic, strong) NSNumber *privateProperty2;
@property (nonatomic, strong) NSDictionary *privateProperty3;

@end

@implementation RuntimeDemoClass

+ (void)metaMethodWithArgument:(NSString *)argument {
    AllLog(@"%@", argument);
}

- (void)publicTestMethod1 {
    AllLog(@"publicTestMethod1");
}

- (void)publicTestMethod2 {
    AllLog(@"publicTestMethod2");
}

- (void)privateMethod {
    AllLog(@"privateMethod");
}

//*1 #### 动态方法解析
//当 Runtime 系统在 Cache 和类的方法列表(包括父类)中找不到要执行的方法时，Runtime 会调用 resolveInstanceMethod: 或 resolveClassMethod: 来给我们一次动态添加方法实现的机会。我们需要用 class_addMethod 函数完成向特定类添加特定方法实现的操作：
+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if ([self instancesRespondToSelector:sel]) {
//        return YES;
//    }
//    
//    [self addMethod:self.self method:sel method:@selector(privateMethod)];
//    return YES;
    return [super resolveInstanceMethod:sel];
}

//*2 #### 消息重定向
//消息转发机制执行前，Runtime 系统允许我们替换消息的接收者为其他对象。通过 - (id)forwardingTargetForSelector:(SEL)aSelector 方法。
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self;
    return [TempClass new];   //让TempClass中相应的SEL去执行该方法
}

//*3 #### 消息转发
//当动态方法解析不做处理返回 NO 时，则会触发消息转发机制。这时 forwardInvocation: 方法会被执行，我们可以重写这个方法来自定义我们的转发逻辑：
- (void)forwardInvocation:(NSInvocation *)invocation {
    TempClass * forwardClass = [TempClass new];
    SEL sel = invocation.selector;
    if ([forwardClass respondsToSelector:sel]) {
        [invocation invokeWithTarget:forwardClass];
    } else {
        [self doesNotRecognizeSelector:sel];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    //查找父类的方法签名
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if(signature == nil) {
        signature = [NSMethodSignature signatureWithObjCTypes:"@@:"];
        
    }
    return signature;
}

@end
