//
//  ZLPlayerLayerView.m
//  LayZhangDemo
//
//  Created by Lay on 2019/5/6.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "ZLPlayerLayerView.h"


@interface ZLPlayerLayerView ()

//@property (nonatomic, strong) AVPlayerLayer * playerLayer;

@end

@implementation ZLPlayerLayerView

- (void)addPlayerLayer:(AVPlayerLayer *)playerLayer {
    
//    _playerLayer = playerLayer;
//    playerLayer.backgroundColor = [UIColor blackColor].CGColor;
//    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    _playerLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:playerLayer];
}

//- (void)layoutSublayersOfLayer:(CALayer *)layer {
//    
//    [super layoutSublayersOfLayer:layer];
//    
//    _playerLayer.frame = self.bounds;
//}

@end
