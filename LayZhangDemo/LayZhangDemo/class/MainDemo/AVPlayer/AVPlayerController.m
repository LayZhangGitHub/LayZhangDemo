
//
//  AVPlayerController.m
//  LayZhangDemo
//
//  Created by Lay on 2019/5/6.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "AVPlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZLVideoPlayerView.h"
#import "ZLVideoModel.h"

@interface AVPlayerController ()

@property (nonatomic, strong) ZLVideoPlayerView *mView;

@end

@implementation AVPlayerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData];
    [self addSubviews];
    [self.mView play];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)loadData {
    
//    NSArray * titleArr = @[@"视频一"];
//    NSArray * urlArr = @[@"http://v2.hucdn.com//upload/pvideo/1905/05/15570549520349_960x720.mp4"];
    
    ZLVideoModel *model = [ZLVideoModel new];
    model.url = [NSURL URLWithString:@"http://v2.hucdn.com//upload/pvideo/1905/05/15570549520349_960x720.mp4"];
    
    [self.mView setVideoModel:model];
}

- (void)addSubviews {
    [self.view addSubview:self.mView];
}

- (ZLVideoPlayerView *)mView {
    if (!_mView) {
        _mView = [[ZLVideoPlayerView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 9 * SCREENWIDTH / 16)];
    }
    return _mView;
}

@end
