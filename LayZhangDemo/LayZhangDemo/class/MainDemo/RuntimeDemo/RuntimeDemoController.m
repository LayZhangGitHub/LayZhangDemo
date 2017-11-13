//
//  RuntimeDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/25.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "RuntimeDemoController.h"
#import "NSObject+Runtime.h"
#import "RuntimeDemoClass.h"

@interface RuntimeDemoController () {
    NSString *name;
}

@end

@implementation RuntimeDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithTitle:@"runtimeDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self getClassDemo];
    
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    
    BOOL res3 = [(id)[RuntimeDemoController class] isKindOfClass:[RuntimeDemoController class]];
    BOOL res4 = [(id)[RuntimeDemoController class] isMemberOfClass:[RuntimeDemoController class]];
    
      NSLog(@"%d %d %d %d", res1, res2, res3, res4);
}

- (void)methodDemo {
    
    /**
     typedef struct objc_selector *SEL; //SEL
     id (*IMP)(id, SEL, ...)            //IMP
     
     
     typedef struct objc_method *Method;
     struct objc_method {
        SEL method_name                     OBJC2_UNAVAILABLE;  // 方法名
        char *method_types                  OBJC2_UNAVAILABLE;
        IMP method_imp                      OBJC2_UNAVAILABLE;  // SLE 对应 IMP 方法实现(方法实现地址)
     }
     **/
    
//    // 调用指定方法的实现
//    id method_invoke ( id receiver, Method m, ... );
//
//    // 调用返回一个数据结构的方法的实现
//    void method_invoke_stret ( id receiver, Method m, ... );
//    
//    // 获取方法名
//    SEL method_getName ( Method m );
//    
//    // 返回方法的实现
//    IMP method_getImplementation ( Method m );
//    
//    // 获取描述方法参数和返回值类型的字符串
//    const char * method_getTypeEncoding ( Method m );
//    
//    // 获取方法的返回值类型的字符串
//    char * method_copyReturnType ( Method m );
//    
//    // 获取方法的指定位置参数的类型字符串
//    char * method_copyArgumentType ( Method m, unsigned int index );
//    
//    // 通过引用返回方法的返回值类型字符串
//    void method_getReturnType ( Method m, char *dst, size_t dst_len );
//    
//    // 返回方法的参数的个数
//    unsigned int method_getNumberOfArguments ( Method m );
//    
//    // 通过引用返回方法指定位置参数的类型字符串
//    void method_getArgumentType ( Method m, unsigned int index, char *dst, size_t dst_len );
//    
//    // 返回指定方法的方法描述结构体
//    struct objc_method_description * method_getDescription ( Method m );
//    
//    // 设置方法的实现
//    IMP method_setImplementation ( Method m, IMP imp );
//    
//    // 交换两个方法的实现
//    void method_exchangeImplementations ( Method m1, Method m2 );
}

- (void)getClassDemo {
    RuntimeDemoClass *runtimeclass = [[RuntimeDemoClass alloc] init];
    
     [RuntimeDemoClass isMetaClass] ? NSLog(@"true") : NSLog(@"false");
     [runtimeclass isMetaClass] ? NSLog(@"true") : NSLog(@"false");
    
    
    
    
    // 返回对象的类
    Class class1 = [RuntimeDemoClass class];
    Class class2 = [runtimeclass class];
    Class class3 = NSClassFromString(@"RuntimeDemoClass");
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *value = @"value";
    Class c1 = [runtimeclass class];
    Class c2 = object_getClass(runtimeclass);
//    Class c2 = [runtimeclass class];
//    Class c3 = object_getClass(c1);
    [dic setObject:value forKey:c1];
    NSLog(@"%lu", (unsigned long)[dic count]);
    [dic setObject:value forKey:c2];
    NSLog(@"%lu", (unsigned long)[dic count]);
//    [dic setObject:value forKey:c3];
//    NSLog(@"%lu", (unsigned long)[dic count]);
    
    //    1.isKindOfClass           // 判断是否是这个类或者子类 （对象方法）
    //    2.isSubclassOfClass       // 判断是否是这个类或者子类 （类方法）
    //    3.isMemberOfClass         // 判断是否是这个类（对象方法）
    
    // getClassName
//    NSLog(@"%@", runtimeclass.getClassName);
//    NSLog(@"%@", [RuntimeDemoClass getClassName]);
    
    //  判断是否是元类
//    NSLog(@"%@", class1);
//    class_isMetaClass(class1) ? NSLog(@"yes") : NSLog(@"no");
//    NSLog(@"%@", object_getClass(class1));
//    class_isMetaClass(object_getClass(class1)) ? NSLog(@"yes") : NSLog(@"no");
//    class_isMetaClass() ? NSLog(@"yes") : NSLog(@"no");
    
    // 添加方法
//    [RuntimeDemoClass addMethod:@selector(pppp) fromClass:self.class];
    [RuntimeDemoClass addMetaMethod:class_getInstanceMethod(self.class, @selector(pppp))];
//    if ([runtimeclass respondsToSelector:@selector(pppp)]) {
//        [runtimeclass performSelector:@selector(pppp)];
//    }
//    
//    if ([RuntimeDemoClass respondsToSelector:@selector(pppp)]) {
//        [RuntimeDemoClass performSelector:@selector(pppp)];
//    }
    
    // 获取 变量列表
    // 属性列表也会隐性的有 加下划线的 变量
    NSArray *ivarList = [RuntimeDemoClass getIvarList];
    
    // 获取 属性列表
    NSArray *propertyList = [RuntimeDemoClass getPropertyList];
    
    // 获取实例对象方法
    NSArray *methodList = [RuntimeDemoClass getMethodList];
    
    // 获取类方法
    NSArray *metaMethodList = [RuntimeDemoClass getMetaMethodList];
    
    // 获取协议列表
    NSArray *protocolList = [RuntimeDemoClass getProtocolList];
    
    
    
//    NSLog(@"%@", [runtimeclass class]);
//        NSLog(@"%@", object_getClass([runtimeclass class]));
    //    NSLog(@"%@", object_getClass(object_getClass([runtimeclass class])));
    
    //    Class class1 =  NSClassFromString(@"RuntimeDemoClass");
    //    id a = [[class1 alloc] init];
    
//    [RuntimeDemoClass methodChange:@selector(publicTestMethod1) method:@selector(publicTestMethod2)];
//    [runtimeclass publicTestMethod1];
    [runtimeclass publicUnImpMethod3]; //publicUnImpMethod3 未具体实现
    
}

- (void)pppp {
    // 成员变量 和 属性都是使用的 添加方法的那个类
//    NSLog(@".... %@", name);
    
    NSLog(@".......");
}

@end
