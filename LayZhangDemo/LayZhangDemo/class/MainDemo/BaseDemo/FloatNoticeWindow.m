//
//  FloatNoticeWindow.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/31.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "FloatNoticeWindow.h"
#import "MyFPSLabel.h"

#define MaxCount 10

@interface FloatNoticeWindow()

@property (nonatomic, weak) MyFPSLabel *fpsLabel;
@property (nonatomic,strong)UIPanGestureRecognizer *pan;

@end

@implementation FloatNoticeWindow


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initComponentFrame:frame];
    }
    return self;
}

- (void)initComponentFrame:(CGRect)frame {
    self.backgroundColor = ZLBlackColor;
    self.windowLevel = UIWindowLevelAlert + 1;
    self.rootViewController = [UIViewController new];
    [self makeKeyAndVisible];
    
    MyFPSLabel *fpsLabel = [MyFPSLabel new];
    _fpsLabel = fpsLabel;
    
    [_fpsLabel sizeToFit];
    [self addSubview:_fpsLabel];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    titleLabel.text = @"连接状态 已 初始化";
}

- (void)hideWindow {
//    NSLog(@"hide.....");
    // do hide action here
}

- (void)layoutSubviews {
    _fpsLabel.frame = CGRectMake(0, 0, 50, 30);
}

- (void)dealloc {
    NSLog(@"FloatNoticeWindow dealloc");
}

@end
