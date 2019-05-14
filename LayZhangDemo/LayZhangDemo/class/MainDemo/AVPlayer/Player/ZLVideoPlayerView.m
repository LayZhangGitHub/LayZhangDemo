//
//  ZLVideoPlayerView.m
//  LayZhangDemo
//
//  Created by Lay on 2019/5/6.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "ZLVideoPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@interface ZLVideoPlayerView()

@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) AVPlayerItem * playerItem;
@property (nonatomic, strong) AVPlayerLayer * playerLayer;
@property (nonatomic, strong) ZLVideoModel *zlModel;
@property (nonatomic, strong) UIButton *payButton;

@property (nonatomic, strong) UIView *layerView;

// 是否第一次播放
@property (nonatomic, assign) BOOL isFirstPlay;
// 是否重播
@property (nonatomic, assign) BOOL isReplay;

@property (nonatomic) CGRect playerFrame;

@end

@implementation ZLVideoPlayerView

#pragma mark - public

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor blackColor];
        _isFirstPlay = YES;
        _isReplay = NO;
        _playerFrame = frame;
        [self addSubviews];
    }
    return self;
}
- (UIButton *)payButton
{
    if (!_payButton) {
        _payButton = [[UIButton alloc] init];
        [_payButton setImage:[UIImage imageNamed:@"video_play"] forState:UIControlStateNormal];
        [_payButton setImage:[UIImage imageNamed:@"video_pause"] forState:UIControlStateSelected];
        [_payButton addTarget:self action:@selector(clickPlaySwitch:) forControlEvents:UIControlEventTouchUpInside];
        _payButton.frame = CGRectMake(30, 30, 50, 50);
    }
    return _payButton;
}

// 设置要播放的视频列表和要播放的视频
- (void)setVideoModel:(ZLVideoModel *)model
{
    if (model.url.absoluteString.length > 0) {
        self.zlModel = model;
    }
//    _isFirstPlay = YES;
    [self setPlayer];
    [self addToolViewTimer];
}

// 点击目录要播放的视频id
- (void)play
{
    //    _titleView.title = self.videoModel.title;
    
//    if (_isFirstPlay) {
//
//        //        _coverImageView.hidden = YES;
//        [self setPlayer];
//        [self addToolViewTimer];
//
//        _isFirstPlay = NO;
//    } else {
//
//        [self.player pause];
//        [self replaceCurrentPlayerItemWithVideoModel:self.zlModel];
//        [self addToolViewTimer];
//    }
}

//切换当前播放的内容
- (void)replaceCurrentPlayerItemWithVideoModel:(ZLVideoModel *)model {
    
    if (self.player) {
        
        if (model) {
            
            //由暂停状态切换时候 开启定时器，将暂停按钮状态设置为播放状态
            //            self.link.paused = NO;
            self.payButton.selected = YES;
            
            //移除当前AVPlayerItem对"loadedTimeRanges"和"status"的监听
            [self removeObserverWithPlayerItem:self.playerItem];
            
            if (model.url) {
                
                AVPlayerItem * playerItem = [AVPlayerItem playerItemWithURL:model.url];
                self.playerItem = playerItem;
                [self addObserverWithPlayerItem:self.playerItem];
                //更换播放的AVPlayerItem
                [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
//                NSInteger index = [self.videoArr indexOfObject:self.videoModel];
//                if (self.delegate && [self.delegate respondsToSelector:@selector(playerView:didPlayVideo:index:)]) {
//
//                    [self.delegate playerView:self didPlayVideo:self.videoModel index:index];
//                }
                self.payButton.enabled = NO;
                //                _toolView.slider.enabled = NO;
            } else {
                
                self.payButton.selected = NO;
                //                _failedView.hidden = NO;
            }
            
        } else {
            
            self.payButton.selected = NO;
            //            _failedView.hidden = NO;
        }
    } else {
        
        self.payButton.selected = NO;
        //        _failedView.hidden = NO;
    }
}

// 暂停
- (void)pause {
    [self.player pause];
    self.payButton.selected = NO;
}
// 停止
- (void)stop {
    
    [self.player pause];
    self.payButton.selected = NO;
}

#pragma mark - add subviews and make constraints

- (void)addSubviews {
    
    // 播放的layerView
    [self addSubview:self.layerView];
    // 添加约束
    [self makeConstraintsForUI];
}

- (void)makeConstraintsForUI {
    
    [self.layerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(@0);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
    }];
}

- (void)layoutSubviews {
    [self.superview bringSubviewToFront:self];
    self.playerLayer.frame = self.layerView.frame;
}

#pragma mark - 监听视频缓冲和加载状态
//注册观察者监听状态和缓冲
- (void)addObserverWithPlayerItem:(AVPlayerItem *)playerItem {
    
    if (playerItem) {
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    }
}

//移除观察者
- (void)removeObserverWithPlayerItem:(AVPlayerItem *)playerItem {
    
    if (playerItem) {
        [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [playerItem removeObserver:self forKeyPath:@"status"];
    }
}

// 监听变化方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    AVPlayerItem * playerItem = (AVPlayerItem *)object;
    
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
        //        NSTimeInterval loadedTime = [self availableDurationWithplayerItem:playerItem];
        //        NSTimeInterval totalTime = CMTimeGetSeconds(playerItem.duration);
        
        //        if (!_toolView.slider.isSliding) {
        //
        //            _toolView.slider.progressPercent = loadedTime/totalTime;
        //        }
        
    } else if ([keyPath isEqualToString:@"status"]) {
        
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            
            NSLog(@"playerItem is ready");
            
            //            [self.player play];
            ////            self.link.paused = NO;
            //            CMTime seekTime = CMTimeMake(self.videoModel.currentTime, 1);
            //            [self.player seekToTime:seekTime completionHandler:^(BOOL finished) {
            
            //                if (finished) {
            //
            //                    NSTimeInterval current = CMTimeGetSeconds(self.player.currentTime);
            //                    _toolView.currentTimeLabel.text = [self convertTimeToString:current];
            //                }
            //            }];
            //            _toolView.slider.enabled = YES;
            //            _toolView.playSwitch.enabled = YES;
            //            _toolView.playSwitch.selected = YES;
        } else{
            
            NSLog(@"load break");
            //            self.failedView.hidden = NO;
        }
    }
}

#pragma mark - private

// 设置播放器
- (void)setPlayer {
    
    if (self.zlModel) {
        
        if (self.zlModel.url) {
            AVPlayerItem * item = [AVPlayerItem playerItemWithURL:self.zlModel.url];
            self.playerItem = item;
            [self addObserverWithPlayerItem:self.playerItem];
            
            if (self.player) {
                
                [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
            } else {
                
                self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
            }
            self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//            self.playerLayer.frame = CGRectMake(0, 0, SCREENWIDTH, 4 / 9 * SCREENWIDTH);
//            [self.layerView.layer addSublayer:self.playerLayer];
            
//            self.playerLayer.frame = self.layerView.frame;
//            [self.layerView addPlayerLayer:self.playerLayer];
        } else {
        }
    } else {
    }
    
//    [self setNeedsLayout];
}

- (void)addToolViewTimer {
    [self addSubview:self.payButton];
}

#pragma mark - toolView delegate

- (void)clickPlaySwitch:(UIButton *)sender {
    sender.selected = !sender.selected;
//    if (_isFirstPlay) {
//        [self setPlayer];
//        [self addToolViewTimer];
//
//        _isFirstPlay = NO;
//    } else
//    if (_isReplay) {
//        [self addToolViewTimer];
//        _isReplay = NO;
//    } else {
        if (!sender.selected) {
            [self.player pause];
            [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
        } else {
            
            [self.player play];
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback  error:nil];
            if ([[AVAudioSession sharedInstance] setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil]) {
                //                [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:nil];
            }
            //            self.link.paused = NO;
            //            [self addToolViewTimer];
        }
//    }
}

#pragma mark - touch event

#pragma mark - setter and getter


- (UIView *)layerView {
    if (!_layerView) {
        _layerView  = [[UIView alloc] init];
    }
    return _layerView;
}

@end
