//
//  CookieViewController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/4.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "CookieViewController.h"
#import "CountDownButton.h"
#import "LoginInputView.h"

@interface CookieViewController ()

@end

@implementation CookieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNavBarWithTitle:@"CookieDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
//    CountDownButton *countDownButton = [[CountDownButton alloc] init];

    CountDownButton *countDownButton = [CountDownButton instanceWithBegin:^(CountDownButton *countDownButton) {
//        countDownButton.enabled = NO;
        
        [countDownButton startCountDownWithSecond:10];

    } couting:^NSString *(CountDownButton *countDownButton, NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
        NSLog(@"%@", title);
        return title;

    } finished:^NSString *(CountDownButton *countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        return @"点击重新获取";
    }];
    
        [countDownButton setFrame:CGRectMake(100, 100, 200, 200)];
        [self.view addSubview:countDownButton];

    [countDownButton setBackgroundColor:[UIColor redColor]];
    
    
    LoginInputView *login = [LoginInputView instanceWithImageName:@"icon_back"];
    login.frame = CGRectMake(20 , 20, 200 , 30);
    [self.view addSubview:login];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
