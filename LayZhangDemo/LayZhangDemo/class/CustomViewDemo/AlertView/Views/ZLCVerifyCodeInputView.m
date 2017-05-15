//
//  ZLVerifyCodeInputView.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLCVerifyCodeInputView.h"

@interface ZLCVerifyCodeInputView() <UITextFieldDelegate>

@property (nonatomic, weak) UITextField *inputField;
@property (nonatomic, weak) UIButton *sendButton;
@property (nonatomic, weak) UIImageView *verticalLine;

@end

@implementation ZLCVerifyCodeInputView

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
    self.layer.cornerRadius = 4.0f;
    self.layer.borderWidth = 0.4f;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.delegate = self;
    textField.placeholder = @"验证码";
    textField.font = [UIFont systemFontOfSize:30 * SCALE];
    textField.secureTextEntry = YES;
    self.inputField = textField;
    [self addSubview:textField];
    
    UIImageView *verticalLine = [[UIImageView alloc] init];
    verticalLine.backgroundColor = ZLColor(211, 211, 211);
    self.verticalLine = verticalLine;
    [self addSubview:verticalLine];
    
    UIButton *sendButton = [[UIButton alloc] init];
    [sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:20 * SCALE];
    [sendButton setTitleColor:ZLColor(70, 151, 251) forState:UIControlStateNormal];
    self.sendButton = sendButton;
    [self addSubview:sendButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat selfWidth = CGRectGetWidth(self.frame);
    CGFloat selfHeight = CGRectGetHeight(self.frame);
    
    CGFloat sendWidth = 130 * SCALE;
    CGFloat sendx = selfWidth - sendWidth;
    [_sendButton setFrame:CGRectMake(sendx, 0, sendWidth, selfHeight)];
    
    CGFloat textFieldx = 28 * SCALE;
    CGFloat textFieldWidth = selfWidth - sendWidth - textFieldx - 21 * SCALE;
    CGRect inputFieldFrame = CGRectMake(textFieldx, 0, textFieldWidth, selfHeight);
    [_inputField setFrame:inputFieldFrame];
    
    CGFloat linex = selfWidth - sendWidth - 10 * SCALE;
    CGFloat lineHeight = 30 * SCALE;
    _verticalLine.size = CGSizeMake(1 * SCALE, lineHeight);
    _verticalLine.center = CGPointMake(linex, selfHeight / 2);
    
}

@end
