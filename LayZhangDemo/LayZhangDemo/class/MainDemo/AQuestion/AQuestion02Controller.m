//
//  AQuestion02Controller.m
//  LayZhangDemo
//
//  Created by WorkLay on 2018/11/13.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "AQuestion02Controller.h"

#import "YYImage.h"
// 网络加载图片f
// 异步加载
// 本地缓存
// 图片渲染 优化

#define URLPath @"https://raw.githubusercontent.com/stonelay/ZLKLineDemo/master/Screenshots/main1.png"

@interface AQuestion02Controller ()<NSCacheDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation AQuestion02Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"Q02" withLeft:[UIImage imageNamed:@"icon_back"]];
    
    [self.view addSubview:self.imageView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //a. 系统回去检查系统缓存中是否存在该名字的图像，如果存在则直接返回。
    //b. 如果系统缓存中不存在该名字的图像，则会先加载到缓存中，在返回该对象。
    [self.imageView setImage:[self getImageFromURL:URLPath]];
    
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(40 * SCALE, 150 * SCALE, SCREENWIDTH / 2, SCREENHEIGHT / 2);
        _imageView.backgroundColor = ZLRedColor;
    }
    return _imageView;
}

#pragma mark - 不做任何处理的下载
- (UIImage *)getImageFromURL:(NSString *)fileURL {
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    UIImage *result = [UIImage imageWithData:data];
    return result;
}




@end
