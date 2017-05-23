//
//  BlockDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BlockDemoController.h"

@interface BlockDemoController ()

// 循环引用 互相持有
@property (nonatomic,strong) void(^myBlock)(int,int);

@end

void (^block)(void);
@implementation BlockDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self blockDemo];
    int a = 1;
    block = ^() {
        NSLog(@"引用变量 %d", a);
        NSLog(@"%@", block);
    };
    [self doSomeBlock:^{
        NSLog(@"引用变量 %d", a);
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
    long (^stackBlock) (int, int) = ^ long (int a, int b) {
        return base +a + b;
    };
    NSLog(@"%@",stackBlock);
}

// 匿名block 并不会copy
- (void)doSomeBlock:(void(^)())block {
//    block();
    NSLog(@"%@", block);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    block();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
