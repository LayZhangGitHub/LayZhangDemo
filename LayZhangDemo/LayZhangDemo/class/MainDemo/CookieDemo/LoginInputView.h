//
//  LoginInputView.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/4.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginInputView : UIView

@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIImageView *leftImageView;

+ (instancetype)instanceWithImageName:(NSString *)imageName;

@end
