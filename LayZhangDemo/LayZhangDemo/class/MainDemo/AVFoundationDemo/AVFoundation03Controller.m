//
//  AVFoundation03Controller.m
//  LayZhangDemo
//
//  Created by LayZhang on 2018/1/10.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "AVFoundation03Controller.h"
#import "CaptureView.h"
/**
 shader demo
 */
@interface AVFoundation03Controller ()

@end

@implementation AVFoundation03Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"AVFoundation03" withLeft:[UIImage imageNamed:@"icon_back"]];
    
    UIView *view = [[CaptureView alloc] init];
    view.frame = self.view.bounds;
    [self.view addSubview:view];
    

}

@end
