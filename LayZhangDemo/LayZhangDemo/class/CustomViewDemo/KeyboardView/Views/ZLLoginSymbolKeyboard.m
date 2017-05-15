//
//  ZLLoginSymbolKeyboard.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ZLLoginSymbolKeyboard.h"
#import "ScreenAuotoSizeScale.h"
//#import "UIView+Extension.h"

@implementation ZLLoginSymbolKeyboard

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImage *image = [UIImage imageNamed:@"c_numKeyboardSmallButton"];
        [self setupNumberButtonsWithImage:image highImage:nil];
    }
    return self;
}

#pragma mark - 数字按钮
- (void)setupNumberButtonsWithImage:(UIImage *)image highImage:(UIImage *)highImage {
    
    NSArray *numberArray = [[NSArray alloc] initWithObjects:@"[", @"]", @"{", @"}", @"#", @"%", @"^", @"*", @"+", @"=",
                            @"_", @"\\", @"|", @"~", @"<", @">", @"?", @"!", @"'", @"\"",
                            @"-", @"/", @":", @";", @"(", @")", @"$", @"&", @"@", @"delete",
                            @"up", @"abc", @"`", @"space", @"space", @"space", @"space", @".", @",",
                            nil];
    
    for (int i = 0; i < [numberArray count]; i ++) {
        UIButton *numBtn = nil;
        NSString *title = [numberArray objectAtIndex:i];
        if ([[title uppercaseString] isEqualToString:@"DELETE"]) {
            UIImage *image = [UIImage imageNamed:@"c_numKeyboardSmallButtonDelete"];
            numBtn = [ZLKeyboardTool setupBasicButtonsWithTitle:title
                                                          image:image
                                                      highImage:nil
                                                     titleColor:[UIColor clearColor]];
            [numBtn addTarget:self action:@selector(numBtnDelete:) forControlEvents:UIControlEventTouchUpInside];
        } else if ([[title uppercaseString]isEqualToString:@"UP"]) {
            UIImage *image = [UIImage imageNamed:@"c_numKeyboardButtonUp"];
            numBtn = [ZLKeyboardTool setupBasicButtonsWithTitle:title
                                                          image:image
                                                      highImage:nil
                                                     titleColor:[UIColor clearColor]];
            [numBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            numBtn = [ZLKeyboardTool setupEnlargeButtonsWithTitle:title
                                                          image:image
                                                      highImage:nil
                                                     titleColor:[UIColor grayColor]];
            [numBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [numBtn.titleLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:13.0f]]];
        [self addSubview:numBtn];
    }
    
    UIButton *returnBtn = [[UIButton alloc] init];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"images/normal/keyboardReturn"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:returnBtn];
    
    [self layout];
}

- (void)numBtnClick:(UIButton *)numBtn {
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickNormalButton:)]) {
        [self.delegate keyboard:self didClickNormalButton:numBtn];
    }
}

- (void)numBtnDelete:(UIButton *)numBtn {
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickDeleteButton:)]) {
        [self.delegate keyboard:self didClickDeleteButton:numBtn];
    }
}

- (void)layout {
    CGFloat topMargin = 30;
    CGFloat bottomMargin = 3;
    CGFloat leftMargin = 3;
    CGFloat colMargin = 3;
    CGFloat rowMargin = 3;
    
    int columNumber = 10;
    int rowNumber = 4;
    
    CGFloat topBtnW = (self.width - 2 * leftMargin - (columNumber - 1) * colMargin) / columNumber;
    CGFloat topBtnH = (self.height - topMargin - bottomMargin - (rowNumber - 1) * rowMargin) / rowNumber;
    
    int count = (int)self.subviews.count;
    
    // 布局数字按钮
    for (int i = 0; i < count - 1; i++) {
        int rowNum = i / columNumber;
        int columNum = i % columNumber;
        
        UIButton *btn = self.subviews[i];
        btn.height = topBtnH;
        btn.width = topBtnW;
        btn.centerX = leftMargin + topBtnW / 2 + (topBtnW + colMargin) * columNum;
        btn.centerY = topMargin + topBtnH / 2 + (topBtnH + rowMargin)* rowNum;
    }
    
    UIButton *deleteBtn = self.subviews[29];
    deleteBtn.height = topBtnH * 2 + rowMargin;
    
    UIButton *spaceBtn = self.subviews[33];
    spaceBtn.width = topBtnW * 4 + rowMargin * 3;
    [spaceBtn setBackgroundImage:[UIImage imageNamed:@"c_numKeyboardSpaceButton"] forState:UIControlStateNormal];
    [spaceBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self.subviews[36] setHidden:YES];
    [self.subviews[35] setHidden:YES];
    [self.subviews[34] setHidden:YES];
    
    UIButton *reButton = self.subviews[39];
    reButton.height = topMargin - rowMargin;
    reButton.width = self.width;
    
}


@end
