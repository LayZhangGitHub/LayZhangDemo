//
//  ZLMVerifyCodeAlertView.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLMVerifyCodeAlertView.h"
#import "ZLCVerifyCodeInputView.h"
#import "Masonry.h"

static ZLMVerifyCodeAlertView *_instance;

@interface ZLMVerifyCodeAlertView()

@property (nonatomic, weak) UIButton *shadowButton;

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *errMessageLabel;
@property (nonatomic, weak) ZLCVerifyCodeInputView *inputView;
@property (nonatomic, weak) UIButton *sureButton;
@property (nonatomic, weak) UIButton *cancelButton;

@end

@implementation ZLMVerifyCodeAlertView

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
}

#pragma mark - public
+ (void)show {
    UIButton *shadowButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    shadowButton.backgroundColor = [UIColor blackColor];
    shadowButton.alpha = 0.6;
    [[UIApplication sharedApplication].keyWindow addSubview:shadowButton];
    
    ZLMVerifyCodeAlertView *alert = [self sharedSendVerifyCodeView];
    alert.shadowButton = shadowButton;
    
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    
}


+ (void)dismiss {
    ZLMVerifyCodeAlertView *alert = [self sharedSendVerifyCodeView];
    
    [alert removeFromSuperview];
    
    [alert.shadowButton removeFromSuperview];
}

#pragma mark - update constraints
- (void)updateConstraints {
    [super updateConstraints];
    UIView *superView = self;
    CGSize superSize = super.frame.size;
    CGFloat superViewWidth = superSize.width;
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(54 * SCALE));
        make.leftMargin.rightMargin.equalTo(@0);
        make.height.equalTo(@(34 * SCALE));
    }];
    
    [self.errMessageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(16 * SCALE);
        make.leftMargin.rightMargin.equalTo(@0);
        make.height.equalTo(@(30 * SCALE));
    }];
    
    [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.errMessageLabel.mas_bottom).offset(16 * SCALE);
//        make.leftMargin.rightMargin.equalTo(@(40 * SCALE));
        make.leftMargin.equalTo(@(40 * SCALE));
        make.right.equalTo(@(- 40 * SCALE));
        make.height.equalTo(@(90 * SCALE));
    }];
    
    [self.cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_bottom).offset(40 * SCALE);
        make.width.equalTo(@(superViewWidth / 2 - 58 * SCALE));
        make.height.equalTo(@(80 * SCALE));
        make.right.equalTo(superView.mas_centerX).offset(-18 * SCALE);
    }];
    
    [self.sureButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_bottom).offset(40 * SCALE);
        make.width.equalTo(@(superViewWidth / 2 - 58 * SCALE));
        make.height.equalTo(@(80 * SCALE));
        make.left.equalTo(superView.mas_centerX).offset(18 * SCALE);
    }];
}

// 这个是必须的
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}


@end
