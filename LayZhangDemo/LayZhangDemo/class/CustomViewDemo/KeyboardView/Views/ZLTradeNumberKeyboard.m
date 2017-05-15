//
//  ZLTradeNumberKeyboard.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ZLTradeNumberKeyboard.h"
//#import "ScreenAuotoSizeScale.h"
//#import "UIView+Extension.h"

//#import "ClientSystemConfig.h"

@interface ZLTradeNumberKeyboard ()

/** 删除按钮 */
//@property (nonatomic, strong) UIButton *deleteBtn;

///** 符号按钮 */
//@property (nonatomic, strong) UIButton *switchSymbolBtn;
//
///** ABC 文字按钮 */
//@property (nonatomic, strong) UIButton *switchLetterBtn;


@end

@implementation ZLTradeNumberKeyboard

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImage *image = [UIImage imageNamed:@"c_numKeyboardButton"];
        //        UIImage *highImage = [UIImage imageNamed:@"c_numKeyboardButtonSel"];
        
        [self setupNumberButtonsWithImage:image highImage:nil];
    }
    return self;
}

#pragma mark - 数字按钮
- (void)setupNumberButtonsWithImage:(UIImage *)image highImage:(UIImage *)highImage {
    
//    NSArray *customAmountArray = [[ClientSystemConfig getInstance] amountCustomArray];
//    
//    NSArray *numberArray = [[NSArray alloc] initWithObjects:
//                            @"7", @"8", @"9", [customAmountArray objectAtIndex:0],
//                            @"4", @"5", @"6", [customAmountArray objectAtIndex:1],
//                            @"1", @"2", @"3", [customAmountArray objectAtIndex:2],
//                            @"00", @"0", @".", @"delete", nil];

    NSArray *numberArray = [[NSArray alloc] initWithObjects:
                            @"7", @"8", @"9", @"2000",
                            @"4", @"5", @"6", @"5000",
                            @"1", @"2", @"3", @"8000",
                            @"00", @"0", @".", @"delete", nil];
    
    for (int i = 0; i < [numberArray count]; i ++) {
        UIButton *numBtn = nil;
        NSString *title = [numberArray objectAtIndex:i];
        if ([title isEqualToString:@"delete"]) {
            UIImage *image = [UIImage imageNamed:@"c_numKeyboardButtonDelete"];
            numBtn = [ZLKeyboardTool setupBasicButtonsWithTitle:title
                                                          image:image
                                                      highImage:nil
                                                     titleColor:[UIColor clearColor]];
            [numBtn addTarget:self action:@selector(numBtnDelete:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            numBtn = [ZLKeyboardTool setupBasicButtonsWithTitle:title
                                                          image:image
                                                      highImage:nil
                                                     titleColor:[UIColor grayColor]];
            [numBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        //        if (i == ([numberArray count] - 1)) {
        //            [numBtn addTarget:self action:@selector(numBtnDelete:) forControlEvents:UIControlEventTouchUpInside];
        //        } else {
        //            [numBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //        }
//        [numBtn.titleLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:13.0f]]];
        [self addSubview:numBtn];
    }
    
    UIButton *returnBtn = [[UIButton alloc] init];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"images/normal/keyboardReturn"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:returnBtn];
    
    [self setMultipleTouchEnabled:false];
}

//- (void)numBtnClick:(UIButton *)numBtn {
//    if ([self.delegate respondsToSelector:@selector(tradeNumberKeyboard:didClickButton:)]) {
//        [self.delegate tradeNumberKeyboard:self didClickButton:numBtn];
//    }
//}

- (void)numBtnClick:(UIButton *)numBtn {
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickNormalButton:)]) {
        [self.delegate keyboard:self didClickNormalButton:numBtn];
    }
}

//- (void)numBtnDelete:(UIButton *)numBtn {
//    if ([self.delegate respondsToSelector:@selector(customKeyboardDidClickDeleteButton:)]) {
//        [self.delegate customKeyboardDidClickDeleteButton:numBtn];
//    }
//}

- (void)numBtnDelete:(UIButton *)numBtn {
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickDeleteButton:)]) {
        [self.delegate keyboard:self didClickDeleteButton:numBtn];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat topMargin = 30;
    CGFloat bottomMargin = 3;
    CGFloat leftMargin = 3;
    CGFloat colMargin = 3;
    CGFloat rowMargin = 3;
    
    int colNumber = 4;
    int rowNumber = 4;
    
    CGFloat topBtnW = (self.width - 2 * leftMargin - (colNumber - 1) * colMargin) / colNumber;
    CGFloat topBtnH = (self.height - topMargin - bottomMargin - (rowNumber - 1) * rowMargin) / rowNumber;
    
    int count = (int)self.subviews.count;
    
    // 布局数字按钮
    for (int i = 0; i < count - 1; i++) {
        int rowIndex = i / colNumber;
        int columIndex = i % colNumber;
        
        UIButton *btn = self.subviews[i];
        btn.height = topBtnH;
        btn.width = topBtnW;
        btn.centerX = leftMargin + topBtnW / 2 + (topBtnW + colMargin) * columIndex;
        btn.centerY = topMargin + topBtnH / 2 + (topBtnH + rowMargin)* rowIndex;
    }
    
    UIButton *reButton = self.subviews[count - 1];
    reButton.height = topMargin - rowMargin;
    reButton.width = self.width;
    
}

@end
