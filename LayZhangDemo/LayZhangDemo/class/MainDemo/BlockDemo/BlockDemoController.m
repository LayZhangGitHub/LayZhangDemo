//
//  BlockDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BlockDemoController.h"
#import "MyBlockObject.h"

@interface BlockDemoController ()

@property (nonatomic, strong) NSString *myString;

// 循环引用 互相持有
@property (nonatomic,strong) void(^myBlock)();
@property (nonatomic, strong) MyBlockObject *mObject;

@end

void (^block)(void);


@implementation BlockDemoController
static int staticValue = 100;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"BlockDemoController" withLeft:[UIImage imageNamed:@"icon_back"]];
    
   static int mValue = 100;
    
    ^ {
        mValue += 10;
        NSLog(@"%d", mValue);
        NSLog(@"sss %@", self);
    }();
    
    
    
    __block int temp = 0;
//    void (^stackBlock)(void) = ^ {
////        NSLog(@"%d", temp);
//    };
//    NSLog(@"%@", stackBlock);
    NSLog(@"statck block %@", ^ {
        NSLog(@"%d", temp);
    });
    
//    self.myString = @"123";
    
    self.mObject = [[MyBlockObject alloc] init];
    // 测试 内存泄漏
//    self.mObject.mmBlock = ^{
//        self.myString = @"11111";
//    };
    // 若 是 匿名block 每引用， 不会循环引用
    [self.mObject doSome:^{
        self.myString = @"123";
    }];
    
    
    [self blockDemo];
    __block int a = 1;
    NSObject *aObject = [[NSObject alloc] init];
    block = ^() {
        NSLog(@"引用变量 %d", a);
        
        NSLog(@"%@", block);
//        self.myString = @"123";
    };
    
    NSLog(@"%@, object", aObject);
    [self doSomeBlock:^{
        NSLog(@"引用变量 %d", a);
        NSLog(@"引用变量 %@", self);
        NSLog(@"%@, object", aObject);
//        self.myString = @"12";
    }];
}

- (void)blockDemo {
    [self globalBlock];
    [self stackBlock];
}

// 在block内部没有引用任何外部变量
// 存储在程序的数据区域(text段)；对NSGlobalBlock的retain、copy、release操作都无效
- (void)globalBlock {
    void (^globalBlock) () = ^ () {
        NSLog(@"global block");
    };
    NSLog(@"%@", globalBlock);//__NSGlobalBlock__
}

// 在block内部引用外部变量 在arc下，执行了copy 所以是在堆上的
- (void)stackBlock {
    int base = 100;
    __block NSObject *object = [[NSObject alloc] init];
    NSLog(@"self is %@", object);
    long (^stackBlock) () = ^ long () {
//        return base +a + b;
//        return self.myString;
//        return base;
//        NSLog(@"%@", stackBlock);

        NSLog(@"self is %@", object);
        return 111;
    };
    stackBlock();
    NSLog(@"...==%@",stackBlock);
}

// 匿名block 并不会copy
- (void)doSomeBlock:(void(^)())block {
    block();
    
    NSLog(@"...%@", block);// 若引用 变量 则在 stackblock、 若没有 则是 __NSGlobalBlock__
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    block();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"block demo controller dealloc");
}

@end
