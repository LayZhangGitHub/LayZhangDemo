//
//  SwizzlingController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/18.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "SwizzlingController.h"
#import "UIViewController+Swizzling.h"
//#import "UIButton+LogButton.h"
#import "UIControl+Log.h"
#import "UIControl+YYAdd.h"

@interface SwizzlingController ()

@property (nonatomic, strong) NSString *mValue;

@property (nonatomic, weak) NSMutableArray *mwArray;

@end

@implementation SwizzlingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"Swizzling" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self addButton];
}

- (void)addButton {
    
    UIButton *buttonA = [[UIButton alloc] init];
    
    [buttonA addLogTarget:self action:@selector(addTargetA:) forControlEvents:UIControlEventTouchUpInside];
    buttonA.frame = CGRectMake(0, 100, 100, 100);
    buttonA.backgroundColor = ZLRedColor;
    [self.view addSubview:buttonA];
    
    UIButton *buttonB = [[UIButton alloc] init];
    [buttonB addLogTarget:self action:@selector(addTargetB:) forControlEvents:UIControlEventTouchUpInside];
    buttonB.frame = CGRectMake(100, 100, 100, 100);
    buttonB.backgroundColor = ZLBlackColor;
    [self.view addSubview:buttonB];
    
}

- (void)addTargetA:(id)sender {
    NSLog(@"addTargetA");
}

- (void)addTargetB:(id)sender {
    NSLog(@"addTargetB");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"viewcontroler dealloc");
}

@end
