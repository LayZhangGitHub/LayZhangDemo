//
//  CountDownButton.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/4.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "CountDownButton.h"

@interface CountDownButton()

@property (nonatomic, assign) NSInteger second;
@property (nonatomic, assign) NSInteger totalSecond;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSDate *startDate;

@end

@implementation CountDownButton

+ (instancetype)instanceWithBegin:(CountDownBegin)begin
                          couting:(CountDownCouting)counting
                         finished:(CountDownFinished)finished {
    CountDownButton *cdButton = [[CountDownButton alloc] init];
    cdButton.countBeginBlock = begin;
    cdButton.coutingBlock = counting;
    cdButton.finisedBlock = finished;
    
    return cdButton;
}


- (instancetype)init {
    if (self = [super init]) {
        [self initTouch];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initTouch];
    }
    return self;
}

- (void)initTouch {
    [self addTarget:self
             action:@selector(touch:)
   forControlEvents:UIControlEventTouchUpInside];
}


- (void)touch:(id)sender {
    if (self.countBeginBlock) {
        self.countBeginBlock(sender);
    }
}

- (void)startCountDownWithSecond:(NSUInteger)second {
    self.totalSecond = second;
    self.second = second;
    
    if (self.timer) {
        [self stopCountDown];
    }
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
//                                                  target:self
//                                                selector:@selector(timerStart:)
//                                                userInfo:nil
//                                                 repeats:YES];
    self.timer = [NSTimer timerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(timerStart:)
                                       userInfo:nil
                                        repeats:YES];
    self.startDate = [NSDate date];
    self.timer.fireDate = [NSDate distantPast];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}


- (void)timerStart:(NSTimer *)theTimer {
    double deltaTime = [[NSDate date] timeIntervalSinceDate:self.startDate];
    
    self.second = self.totalSecond - (NSInteger)(deltaTime + 0.5) ;
    
    
    if (_second< 0.0) {
        [self stopCountDown];
    } else {
        if (self.coutingBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *title = self.coutingBlock(self, self.second);
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitle:title forState:UIControlStateDisabled];
            });
        } else {
            NSString *title = [NSString stringWithFormat:@"%zd秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
            
        }
    }
}


- (void)stopCountDown{
    if (self.timer) {
        if ([self.timer respondsToSelector:@selector(isValid)]) {
            if ([self.timer isValid]) {
                [self.timer invalidate];
                self.second = self.totalSecond;
                if (self.finisedBlock) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *title = self.finisedBlock(self, self.totalSecond);
                        [self setTitle:title forState:UIControlStateNormal];
                        [self setTitle:title forState:UIControlStateDisabled];
                    });
                }
                else
                {
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];
                    
                }
            }
        }
    }
}

- (void)dealloc {
    NSLog(@"count button dealloc");
}

@end



