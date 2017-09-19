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

@property (nonatomic, strong) UIImageView *imageView;
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
    
    UIButton *click = [[UIButton alloc] init];
    click.backgroundColor = ZLBlackColor;
    click.frame = CGRectMake(200, 300, 200, 40);
    [self.view addSubview:click];
    [click addTarget:self action:@selector(showTest:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:@"icon_test"]];
    self.imageView = imageView;
    self.imageView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [self.view addSubview:imageView];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(showTest:)]];
}

- (void)showTest:(id)sender {
    NSLog(@"cli");
    DelayEnableButton(sender, 2);
    
    [UIView animateWithDuration:0.4f animations:^{
        
        _imageView.frame = CGRectMake(_imageView.left - 100, _imageView.top - 100, _imageView.width + 200, _imageView.height + 200);
        _imageView.alpha = 0;
        
    }completion:^(BOOL finished) {
    }];
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
