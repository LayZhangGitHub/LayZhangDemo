//
//  LoadInitController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/23.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "LoadInitController.h"
#import "Dog.h"
#import "Cat.h"

/**
 
 |                      | load                      | initialize                      |
 |--------------------- | :----------------------:  |:--------------------------------|
 |执行时间               |在程序运行后立即执行           |在类方法第一次被调用时执行，且只执行一次 |
 |若自身未定义，是否调用父类 |否                          |是                               |
 |Category中的调用       |全都执行，但是在比类方法晚       |若父方法未执行，两个都会执行，且先父后子 |
 
 **/

@interface LoadInitController ()

@end

@implementation LoadInitController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"LoadInitDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self objInitDemo];
}

- (void)objInitDemo {
//    Animal *animal = [Animal new];
//    Dog *dog = [Dog new];
//    Cat *cat = [Cat new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
