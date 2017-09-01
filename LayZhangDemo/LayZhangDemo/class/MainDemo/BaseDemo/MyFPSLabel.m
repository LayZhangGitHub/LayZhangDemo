//
//  MyFPSLabel.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/31.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MyFPSLabel.h"
#import "MyWeakProxy.h"

#define kSize CGSizeMake(55, 20)

@interface MyFPSLabel()

@property (nonatomic, strong) UIFont *myFont;
@property (nonatomic, strong) UIFont *subFont;
@property (nonatomic, strong) CADisplayLink *myLink;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) NSInteger count;
@end

@implementation MyFPSLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size = kSize;
    }
    
    if ([super initWithFrame:frame]){
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
        
        _myFont = [UIFont systemFontOfSize:14];
        if (_myFont) {
            _subFont = [UIFont systemFontOfSize:4];
        } else {
            _myFont = [UIFont systemFontOfSize:14];
            _subFont = [UIFont systemFontOfSize:4];
        }
        
        _myLink = [CADisplayLink displayLinkWithTarget:[MyWeakProxy proxyWithTarget:self]
                                              selector:@selector(tick:)];
        [_myLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return kSize;
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    
    NSString *text1 = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
    NSLog(@"%@", text1);
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length - 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 3, 3)];
    [text addAttribute:NSFontAttributeName value:_myFont range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName value:_subFont range:NSMakeRange(text.length - 4, 1)];
    self.attributedText = text;
}

- (void)dealloc {
    [_myLink invalidate];
    NSLog(@"MyFPSLabel release");
}

@end
