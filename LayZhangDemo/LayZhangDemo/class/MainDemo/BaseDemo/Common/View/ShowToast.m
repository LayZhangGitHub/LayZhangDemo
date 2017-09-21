//
//  ShowToast.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/20.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ShowToast.h"

@implementation ShowToast


+ (void)showWithString:(NSString *)str{
    
    CGFloat height = 90 * SCALE;
    
    CGSize size = [str sizeWithSize:CGSizeMake(SCREENWIDTH, height) font:15];
    
    CGFloat width = size.width + 60 * SCALE;
    
    UILabel *label = [UILabel labelWithText:str textColor:[UIColor whiteColor] font:15 textAliment:NSTextAlignmentCenter];
    
    label.layer.cornerRadius = 16*SCALE;
    label.clipsToBounds = YES;
    
    label.frame = CGRectMake(SCREENWIDTH/2 - width/2, SCREENHEIGHT/2 - 45 * SCALE, width, height);
    
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0;
    
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        label.alpha = 0.6;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        
        [UIView animateWithDuration:0.25 animations:^{
            
            label.alpha = 0;
        } completion:^(BOOL finished) {
            
            [label removeFromSuperview];
        }];
    });
    
}


@end
