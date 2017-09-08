//
//  ZLVerifyCodeAlertView.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLCVerifyCodeAlertView.h"
#import "ZLCVerifyCodeInputView.h"

static ZLCVerifyCodeAlertView *_instance;

@interface ZLCVerifyCodeAlertView ()
@property (nonatomic, weak) UIButton *shadowButton;

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *errMessageLabel;
@property (nonatomic, weak) ZLCVerifyCodeInputView *inputView;
@property (nonatomic, weak) UIButton *sureButton;
@property (nonatomic, weak) UIButton *cancelButton;

@end

@implementation ZLCVerifyCodeAlertView

+ (instancetype)sharedSendVerifyCodeView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        CGFloat width = 578 * SCALE;
        CGFloat x = (SCREENWIDTH - width)/2;
        CGFloat height = 380 * SCALE;
        CGFloat y = (SCREENHEIGHT - height)/2;
        _instance = [[self alloc] initWithFrame:CGRectMake(x, y, width, height)];
    });
    
    return _instance;
}


#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        [self initContent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initContent];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initContent];
    }
    return self;
}

- (void)initContent {
    
    self.layer.cornerRadius = 8 * SCALE;
    self.clipsToBounds = YES;
    self.backgroundColor = ZLWhiteColor;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"验证码发送";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:34 * SCALE];
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    UILabel *errMessageLabel = [[UILabel alloc] init];
    errMessageLabel.text = @"errMessage";
    errMessageLabel.textAlignment = NSTextAlignmentCenter;
    errMessageLabel.font = [UIFont systemFontOfSize:24 * SCALE];
    errMessageLabel.textColor = ZLRedColor;
    self.errMessageLabel = errMessageLabel;
    [self addSubview:errMessageLabel];
    
    ZLCVerifyCodeInputView *inputView = [[ZLCVerifyCodeInputView alloc] init];
    self.inputView = inputView;
    [self addSubview:inputView];
    
    UIButton *sureButton = [UIButton buttonWithTitle:@"确定"
                                          titleColor:ZLRGB(70, 151, 251)
                                           titleFont:26];
    sureButton.layer.cornerRadius = 40 * SCALE;
    sureButton.layer.borderWidth = 1.0f;
    sureButton.layer.borderColor = ZLRGB(70, 151, 251).CGColor;
    sureButton.backgroundColor = ZLRGB(70, 151, 251);
    [sureButton setTitleColor:ZLWhiteColor forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:34 * SCALE];
    self.sureButton = sureButton;
    [self addSubview:sureButton];
    [sureButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelButton = [UIButton buttonWithTitle:@"取消"
                                            titleColor:ZLRGB(70, 151, 251)
                                             titleFont:26];
    cancelButton.layer.cornerRadius = 40 * SCALE;
    cancelButton.layer.borderWidth = 1.0f;
    cancelButton.layer.borderColor = ZLRGB(70, 151, 251).CGColor;
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:34 * SCALE];
    self.cancelButton = cancelButton;
    [cancelButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
}

- (void)buttonClicked:(id)sender {
    if (sender == self.sureButton) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectAlert:isOK:)]) {
            [self.delegate didSelectAlert:self isOK:true];
        }
    }
    
    if (sender == self.cancelButton) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectAlert:isOK:)]) {
            [self.delegate didSelectAlert:self isOK:false];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat selfWidth = CGRectGetWidth(self.frame);
//    CGFloat selfHeight = CGRectGetHeight(self.frame);
    
    CGFloat titleTop = 52 * SCALE;
    CGFloat titleHeight = 34 * SCALE;
    CGSize titleSize = CGSizeMake(selfWidth, titleHeight);
    CGPoint titleCenter = CGPointMake(selfWidth / 2, titleTop + titleHeight / 2);
    _titleLabel.size = titleSize;
    _titleLabel.center = titleCenter;
    
    CGFloat errTop = titleTop + titleHeight + 16 * SCALE;
    CGFloat errHeight = 30 * SCALE;
    CGSize  errSize = CGSizeMake(selfWidth, errHeight);
    CGPoint errCenter = CGPointMake(selfWidth / 2, errTop + errHeight / 2);
    _errMessageLabel.size = errSize;
    _errMessageLabel.center = errCenter;
    
    CGFloat inputEdge = 40 * SCALE;
    CGFloat inputTop = errTop + errHeight + 16 * SCALE;
    CGFloat inputWidth = selfWidth - inputEdge * 2;
    CGFloat inputHeight = 90 * SCALE;
    
    CGSize inputSize = CGSizeMake(inputWidth, inputHeight);
    CGPoint inputCenter = CGPointMake(selfWidth / 2, inputTop + inputHeight / 2);
    _inputView.size = inputSize;
    _inputView.center = inputCenter;
    
    CGFloat buttonWidth = (selfWidth - inputEdge * 2 - 36 * SCALE) / 2;
    CGFloat buttonHeight = 80 * SCALE;
    CGFloat buttonTop = inputTop + inputHeight + 40 * SCALE;
    
    [_cancelButton setFrame:CGRectMake(inputEdge, buttonTop, buttonWidth, buttonHeight)];
    [_sureButton setFrame:CGRectMake(inputEdge + buttonWidth + 36 * SCALE, buttonTop, buttonWidth, buttonHeight)];
}

#pragma mark - public
+ (void)show {
    UIButton *shadowButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    shadowButton.backgroundColor = [UIColor blackColor];
    shadowButton.alpha = 0.6;
    [[UIApplication sharedApplication].keyWindow addSubview:shadowButton];
    
    ZLCVerifyCodeAlertView *alert = [self sharedSendVerifyCodeView];
    alert.shadowButton = shadowButton;
    
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    
}


+ (void)dismiss {
    ZLCVerifyCodeAlertView *alert = [self sharedSendVerifyCodeView];
    
    [alert removeFromSuperview];
    
    [alert.shadowButton removeFromSuperview];
}

@end
