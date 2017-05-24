//
//  JSONParseDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/23.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "JSONParseDemoController.h"
#import "JSONModel01.h"

@interface JSONParseDemoController ()

@end

@implementation JSONParseDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"JSONParseDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self jsonModelUseDemo];
}

- (void)jsonModelUseDemo {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSONDemo" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *oriJSONString = [dic objectForKey:@"Ori01"];
    NSError* err = nil;
    JSONModel01* json = [[JSONModel01 alloc] initWithString:oriJSONString error:&err];
    NSLog(@"%d", json.intValue);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
