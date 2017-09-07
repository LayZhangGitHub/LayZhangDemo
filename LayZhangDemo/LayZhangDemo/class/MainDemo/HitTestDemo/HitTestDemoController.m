//
//  HitTestDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/6.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "HitTestDemoController.h"
#import "MyHitTestButton.h"
#import "MyHitTestView.h"

@interface HitTestDemoController ()

@end

@implementation HitTestDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"HitTestDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self initContent];
}

- (void)initContent {
    MyHitTestButton *mBtn = [[MyHitTestButton alloc] init];
    mBtn.backgroundColor = [UIColor grayColor];
    mBtn.frame = CGRectMake(100, 120, 100, 200);
    [self.view addSubview:mBtn];
    [mBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    MyHitTestView *mView = [[MyHitTestView alloc]init];
    mView.backgroundColor = [UIColor redColor];
    mView.frame = CGRectMake(-100, 20, 300, 70);
    [mBtn addSubview:mView];
}

- (void)click:(id)sender {
    NSLog(@"mysender %@", sender);
}

@end
