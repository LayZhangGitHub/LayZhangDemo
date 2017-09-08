//
//  MasonryViewController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/31.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MasonryViewController.h"
#import "BaseViewA.h"
#import "BaseViewB.h"
#import "BaseViewC.h"

@interface MasonryViewController ()

@property (nonatomic, weak) BaseViewA      *viewA;
@property (nonatomic, weak) BaseViewB      *viewB;
@property (nonatomic, weak) BaseViewC      *viewC;

@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"MasonryDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self addContent];
}

- (void)addContent {
    
    BaseViewA *viewA = [[BaseViewA alloc] init];
//    viewA.frame = CGRectMake(20, 80, 300, 300);
    viewA.backgroundColor = ZLBlackColor;
    self.viewA = viewA;
    [self.view addSubview:viewA];
    
    
    BaseViewB *viewB = [[BaseViewB alloc] init];
//    viewB.frame = CGRectMake(20, 80, 200, 200);
    viewB.backgroundColor = ZLRedColor;
    self.viewB = viewB;
    [self.view addSubview:viewB];
    
    
    BaseViewC *viewC = [[BaseViewC alloc] init];
//    viewC.frame = CGRectMake(20, 80, 100, 100);
    viewC.backgroundColor = ZLWhiteColor;
    self.viewC = viewC;
    [self.view addSubview:viewC];
    
//    UIButton *changeButton = [[UIButton alloc] init];
//    changeButton.frame = CGRectMake(0, 0, 100, 100);
//    changeButton.backgroundColor = ZLRGB(100, 200, 10);
//    [self.view addSubview:changeButton];
//    [changeButton addTarget:self action:@selector(changeFrame) forControlEvents:UIControlEventTouchUpInside];
    
    
//    UIView *view1 = [[UIView alloc] init];
//    view1.backgroundColor = ZLBlackColor;
//    self.view1 = view1;
//    [self.view addSubview:view1];
//    
//    BaseView *baseView = [[BaseView alloc] init];
//    baseView.backgroundColor = ZLWhiteColor;
//    self.baseView = baseView;
//    [self.view1 addSubview:baseView];
}

//- (void)changeFrame {
//    [self.viewB setFrame:CGRectMake(10, 10, 150, 150)];
//}

- (void)updateViewConstraints {
    [super updateViewConstraints];
}


@end
