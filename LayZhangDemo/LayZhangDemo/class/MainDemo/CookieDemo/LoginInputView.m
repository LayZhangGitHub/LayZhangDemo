//
//  LoginInputView.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/4.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "LoginInputView.h"
#import "ZLPreMacro.h"

@implementation LoginInputView

- (instancetype)init {
    if (self = [super init]) {
        [self initComponent];
    }
    return self;
}

- (void)initComponent {
    self.layer.cornerRadius = 10.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.backgroundColor = [UIColor grayColor].CGColor;
}

+ (instancetype)instanceWithImageName:(NSString *)imageName {
    LoginInputView *inputView = [[LoginInputView alloc] init];
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    inputView.leftImageView = leftImageView;
    [inputView addSubview:leftImageView];
    
    UITextField *textFeild = [[UITextField alloc] init];
    inputView.textField = textFeild;
    [inputView addSubview:textFeild];
    
    return inputView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _leftImageView.frame = CGRectMake(29 * SCALE, 26 * SCALE, 20 * SCALE, 20 * SCALE);
    _textField.frame = CGRectMake(_leftImageView.right + 29 * SCALE, 0, self.width - 80 * SCALE, self.height);
}
@end
