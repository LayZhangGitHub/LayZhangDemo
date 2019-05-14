//
//  ZLVideoPlayerView.h
//  LayZhangDemo
//
//  Created by Lay on 2019/5/6.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZLVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZLVideoPlayerView : UIView

- (void)setVideoModel:(ZLVideoModel *)model;


// 点击目录要播放的视频id
- (void)play;
/**
 暂停
 */
- (void)pause;

/**
 停止
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
