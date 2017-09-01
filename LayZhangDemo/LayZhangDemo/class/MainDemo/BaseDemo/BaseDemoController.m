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

@interface BaseDemoController ()
@property (nonatomic, strong) MyFPSLabel *myFPSLabel;
@end

@implementation BaseDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"BaseDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self test];
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
}



@end
