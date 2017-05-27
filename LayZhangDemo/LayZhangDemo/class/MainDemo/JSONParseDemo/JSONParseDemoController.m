//
//  JSONParseDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/23.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "JSONParseDemoController.h"
#import "JSONModel01.h"
#import "YJSONModel01.h"

@interface JSONParseDemoController ()

@end

@implementation JSONParseDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"JSONParseDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
//    [self jsonModelUseDemo];
    [self jsonYYModelDemo];
}

- (void)jsonYYModelDemo {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSONDemo" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSError* err = nil;
    
    NSString *ori01JSONString = [dic objectForKey:@"Ori01"];
    
    YJSONModel01 *model01 = [YJSONModel01 yy_modelWithJSON:ori01JSONString];
//    NSLog(@"%@", model01.mModel.name);
    id jsonObject = [model01 yy_modelToJSONObject];
    NSString *s = [model01 yy_modelToJSONString];
}

- (void)jsonModelUseDemo {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSONDemo" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSError* err = nil;
    
    NSString *ori01JSONString = [dic objectForKey:@"Ori01"];
    NSLog(@"%@", ori01JSONString);
    JSONModel01* json01 = [[JSONModel01 alloc] initWithString:ori01JSONString error:&err];
    NSLog(@"%d", json01.intValue);
//    NSLog(@"%@", json01.mModel);
    
    NSString *ori02JSONString = [dic objectForKey:@"Ori02"];
    NSLog(@"%@", ori02JSONString);
    JSONModel01* json02 = [[JSONModel01 alloc] initWithString:ori02JSONString error:&err];
    NSLog(@"%d", json02.intValue);
//    NSLog(@"%@", json02.mModel);
    
//    { "intValue":"10", "stringValue":"string123","mModel":{"name":"myName"} }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
