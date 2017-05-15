//
//  ZLLoginNumberKeyboard.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ZLLoginNumberKeyboard.h"
#import "ScreenAuotoSizeScale.h"
//#import "UIView+Extension.h"


@implementation ZLLoginNumberKeyboard

@synthesize delegate;
@synthesize isNeedPwd;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImage *image = [UIImage imageNamed:@"c_numKeyboardSmallButton"];
        //        UIImage *highImage = [UIImage imageNamed:@"c_numKeyboardButtonSel"];
        isNeedPwd = false;
        [self setupNumberButtonsWithImage:image highImage:nil];
        [self relayout];
    }
    return self;
}

#pragma mark - 数字按钮
- (void)setupNumberButtonsWithImage:(UIImage *)image highImage:(UIImage *)highImage {
    
    //    NSSet *set = [[NSSet alloc] initWithObjects:<#(id), ...#>, nil];
    
//    NSMutableArray *tenArray = [[NSMutableArray alloc] initWithCapacity:<#(NSUInteger)#>];
    
    NSMutableArray *numberArray = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0",
                                   @"q", @"w", @"e", @"r", @"t", @"y", @"u", @"i", @"o", @"p",
                                   @"a", @"s", @"d", @"f", @"g", @"h", @"j", @"k", @"l", @"delete",
                                   @"up", @".?&", @"z", @"x", @"c", @"v", @"b", @"n", @"m",
                                   nil];
    
    //    for (int i = 0; i < 10; i ++) {
    //        for (int j = 0; j < i; j++) {
    //            if (rand() % 2 > 0) {
    //                NSString *temp = [numberArray objectAtIndex:i];
    ////                numberArray ra
    //            }
    //        }
    //    }
    
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
        
        //        [numBtn.titleLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:13.0f]]];
        [self addSubview:numBtn];
    }
    
    UIButton *returnBtn = [[UIButton alloc] init];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"images/normal/keyboardReturn"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:returnBtn];
    
        [self setMultipleTouchEnabled:false];
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

- (void)layoutSubviews {
    [super layoutSubviews];
//    [self relayout];
}

- (void)relayout {
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
    
    NSSet *set = [[NSSet alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    
    NSMutableArray *tenArray = [[NSMutableArray alloc] init];
    for (NSString *temp in set) {
        if ([tenArray count] == 0) {
            [tenArray addObject:temp];
        } else {
            [tenArray insertObject:temp atIndex:arc4random() % ((int)[tenArray count] + 1)];
        }
    }
 
    // 布局数字按钮
    for (int i = 0; i < count - 1; i++) {
        int rowNum = i / columNumber;
        int columNum = i % columNumber;
        
        //        UIButton *btn = self.subviews[i];
        UIButton *btn = nil;
        if (i < 10 && isNeedPwd) {
            NSInteger index = [[tenArray objectAtIndex:i] integerValue];
            btn = self.subviews[index];
        } else {
            btn = self.subviews[i];
        }
        
        btn.height = topBtnH;
        btn.width = topBtnW;
        btn.centerX = leftMargin + topBtnW / 2 + (topBtnW + colMargin) * columNum;
        btn.centerY = topMargin + topBtnH / 2 + (topBtnH + rowMargin)* rowNum;
    }
    
    UIButton *deleteBtn = self.subviews[29];
    deleteBtn.height = topBtnH * 2 + rowMargin;
    
    UIButton *reButton = self.subviews[39];
    reButton.height = topMargin - rowMargin;
    reButton.width = self.width;
}


@end
