//
//  CountDownButton.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/4.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CountDownButton;
typedef NSString* (^CountDownCouting)(CountDownButton *countDownButton,NSUInteger second);
typedef NSString* (^CountDownFinished)(CountDownButton *countDownButton,NSUInteger second);
typedef void (^CountDownBegin)(CountDownButton *countDownButton);

@interface CountDownButton : UIButton

@property (nonatomic, copy) CountDownCouting coutingBlock; //倒计时时间改变回调
@property (nonatomic, copy) CountDownFinished finisedBlock;//倒计时结束回调
@property (nonatomic, copy) CountDownBegin countBeginBlock;//倒计时按钮点击回调

+ (instancetype)instanceWithBegin:(CountDownBegin)begin
                          couting:(CountDownCouting)counting
                         finished:(CountDownFinished)finished;

///开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second;
///停止倒计时
- (void)stopCountDown;

@end
