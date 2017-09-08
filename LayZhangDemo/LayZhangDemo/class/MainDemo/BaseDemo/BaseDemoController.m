//
//  BaseDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/30.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseDemoController.h"
#import "AppInfoManager.h"
#import "MyFPSLabel.h"
#import "ZLAlertView.h"
#import "ZLDropDownMenu.h"

@interface BaseDemoController ()<ZLAlertViewDelegate, ZLDropdownMenuDelegate>
@property (nonatomic, strong) MyFPSLabel *myFPSLabel;
@end

@implementation BaseDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"BaseDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self test];
    [self showMessage:@"123"];
    
    ZLDropDownMenu * dropdownMenu = [[ZLDropDownMenu alloc] init];
    [dropdownMenu setFrame:CGRectMake(20, 80, 100, 40)];
    [dropdownMenu setMenuTitles:@[@"选项一",@"选项二",@"选项三",@"选项四"] rowHeight:30];
    dropdownMenu.delegate = self;
    [self.view addSubview:dropdownMenu];
}


- (void)dropdownMenu:(ZLDropDownMenu *)menu selectedCellNumber:(NSInteger)number{
    NSLog(@"你选择了：%ld",number);
}

- (void)dropdownMenuWillAppear:(ZLDropDownMenu *)menu {
    NSLog(@"--将要显示--");
}
- (void)dropdownMenuDidAppear:(ZLDropDownMenu *)menu {
    NSLog(@"--已经显示--");
}

- (void)dropdownMenuWillDisappear:(ZLDropDownMenu *)menu {
    NSLog(@"--将要隐藏--");
}
- (void)dropdownMenuDidDisappear:(ZLDropDownMenu *)menu {
    NSLog(@"--已经隐藏--");
}

- (void)test {
    
    NSLog(@"short shortVersionString is %@", [AppInfoManager shortVersionString]);
    NSLog(@"short bundleVersion is %@", [AppInfoManager bundleVersion]);
    NSLog(@"short identifierKey is %@", [AppInfoManager identifierKey]);
//    NSLog(@"short version is %@", [AppInfoManager shortVersionString]);
//    NSLog(@"short version is %@", [AppInfoManager shortVersionString]);
    
    _myFPSLabel = [MyFPSLabel new];
    _myFPSLabel.frame = CGRectMake(200, 200, 50, 30);
    [_myFPSLabel sizeToFit];
    [self.view addSubview:_myFPSLabel];
    
//    UIButton *uibutton = [[UIButton alloc] init];
//    [uibutton setBackgroundColor:ZLGray(100)];
//    uibutton.frame = CGRectMake(100, 100, 200, 100);
//    [self.view addSubview:uibutton];
//    [uibutton setImage:[UIImage imageNamed:@"icon_test"] forState:UIControlStateNormal];
//    [uibutton setTitle:@"title" forState:UIControlStateNormal];
//    uibutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 100);
//    uibutton.titleEdgeInsets = UIEdgeInsetsMake(0, -300, 0, 0);
}


- (void)showMessage:(NSString *)message {
    ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"ttitle" message:message containerView:nil delegate:self confirmButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

- (void)alertView:(ZLAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"click1");
}

- (void)alertView:(ZLAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"click2");
}
- (void)alertView:(ZLAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"click3");
}

@end
