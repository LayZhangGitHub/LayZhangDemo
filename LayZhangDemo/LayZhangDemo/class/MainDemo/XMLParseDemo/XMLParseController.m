//
//  XMLParseController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "XMLParseController.h"
#import "LangCaptain.h"

@interface XMLParseController ()

@end

@implementation XMLParseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"XMLParse" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self parse];
}

- (void)parse {
    NSLog(@"----xml parse demo----");
    NSString *err_sample = [[LangCaptain getInstance] getErrMessageByCode:@"ERR_Sample"];
    NSString *langA = [[LangCaptain getInstance] getLangByCode:@"LangA"];
    NSLog(@"parse err_sample is %@", err_sample);
    NSLog(@"parse langA is %@", langA);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
