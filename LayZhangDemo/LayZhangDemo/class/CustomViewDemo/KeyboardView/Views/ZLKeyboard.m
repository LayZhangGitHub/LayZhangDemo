//
//  ZLKeyboard.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ZLKeyboard.h"

//#import "IosLayoutDefine.h"

#import "ZLLoginNumberKeyboard.h"
#import "ZLTradeNumberKeyboard.h"
#import "ZLLoginSymbolKeyboard.h"
#import "CommDataUtil.h"
#import "DecimalUtil.h"
#import "AmountTextField.h"
#import "LimitLengthField.h"
#import "LimitDigistField.h"

#define  AmountMaxLength 7

@interface ZLKeyboard()<ZLCustomKeyboardDelegate> {
    Boolean upState;
    int currentStyle;
}

@property (nonatomic, strong) ZLLoginNumberKeyboard *loginNumberKeyboard;
@property (nonatomic, strong) ZLTradeNumberKeyboard *tradeNumberKeyboard;
@property (nonatomic, strong) ZLLoginSymbolKeyboard *loginSymbolKeyboard;

@property (nonatomic, strong) NSMutableString *inputString;

@end

@implementation ZLKeyboard

@synthesize currentTextField;

- (void)setIsNeedPwd:(Boolean)isNeedPwd {
    [_loginNumberKeyboard setIsNeedPwd:isNeedPwd];
    [_loginNumberKeyboard relayout];
}

- (ZLTradeNumberKeyboard *)tradeNumberKeyboard {
    if (!_tradeNumberKeyboard) {
        _tradeNumberKeyboard = [[ZLTradeNumberKeyboard alloc] initWithFrame:self.bounds];
        _tradeNumberKeyboard.delegate = self;
    }
    upState = false;
    return _tradeNumberKeyboard;
}

- (ZLLoginNumberKeyboard *)loginNumberKeyboard {
    if (!_loginNumberKeyboard) {
        _loginNumberKeyboard = [[ZLLoginNumberKeyboard alloc] initWithFrame:self.bounds];
        _loginNumberKeyboard.delegate = self;
    }
    upState = false;
    return _loginNumberKeyboard;
}

- (ZLLoginSymbolKeyboard *)loginSymbolKeyboard {
    if (!_loginSymbolKeyboard) {
        _loginSymbolKeyboard = [[ZLLoginSymbolKeyboard alloc] initWithFrame:self.bounds];
        _loginSymbolKeyboard.delegate = self;
    }
    upState = false;
    return _loginSymbolKeyboard;
}

- (id)initWithType:(int)type{
    if (self = [super init]) {
        double keyboardHeight = [ScreenAuotoSizeScale CGAutoMakeFloat:180.0f];
        self.frame = CGRectMake(0, SCREEN_HEIGHT - keyboardHeight, SCREEN_WIDTH, keyboardHeight);
        //        self.inputString = [[NSMutableString alloc] initWithString:inputString];
        self.inputString = [[NSMutableString alloc] initWithString:@""];
        upState = false;
        self.backgroundColor = [UIColor lightGrayColor];
        currentStyle = type;
        [self addKeyboard:type];
        [self setMultipleTouchEnabled:false];
    }
    return self;
}

- (void)resetInputString:(NSString *)inputString {
    self.inputString = [[NSMutableString alloc] initWithString:inputString];
}

- (void)addKeyboard:(int)type {
    switch (type) {
        case LoginNumberKeyboard:
            currentStyle = type;
            [self addSubview:self.loginNumberKeyboard];
            [self updateButtonTitle];
            break;
        case LoginSymbolKeyboard:
            currentStyle = type;
            [self addSubview:self.loginSymbolKeyboard];
            [self updateButtonTitle];
            break;
        case TradeNumberKeyboard:
            currentStyle = type;
            [self addSubview:self.tradeNumberKeyboard];
            [self updateButtonTitle];
            break;
        default:
            break;
    }
}

- (void)appendString:(UIButton *)button {
    NSString *addString = @"";
    if (currentStyle == TradeNumberKeyboard) {
        if ([button.currentTitle isEqualToString:@"00"] || [button.currentTitle isEqualToString:@"."]) {
            addString = button.currentTitle;
        } else {
            addString = [@([CommDataUtil numberFromString:button.currentTitle]) stringValue];
        }
    } else {
        if ([[[button currentTitle] uppercaseString] isEqualToString:@"SPACE"]) {
            addString = @" ";
        } else {
            addString = [button currentTitle];
        }
    }
    
    if (currentStyle == TradeNumberKeyboard) {
        if ([button.currentTitle isEqualToString:@"."] && [self.inputString isEqualToString:@""]) {
//            [self.inputString appendString:@"0."];
            [self inputText:@"0."];
        } else if (!([button.currentTitle isEqualToString:@"."] && [self.inputString containsString:@"."])) {
            [self inputText:addString];
        }
    } else {
        [self inputText:addString];
    }
    
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickTextButton:string:)]) {
        [self.delegate keyboard:self didClickTextButton:button string:self.inputString];
    }
}

- (void)inputText:(NSString *)addString {
//    self.currentTextField.text = [DecimalUtil formatNumber:[self.currentTextField.text doubleValue]];
//    self.currentTextField.text = [self.currentTextField.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    
//    if ([currentTextField isKindOfClass:[LimitDigistField class]] && [self.inputString containsString:@"."]) {
//        int digist = ((LimitDigistField *)currentTextField).digist;
//        NSUInteger length = [self.inputString length] - [self.inputString rangeOfString:@"."].location - 1;
//        if(length >= digist) {
//            return;
//        }
//    }
    
    if ([currentTextField isKindOfClass:[LimitLengthField class]] && ([self.inputString length] + [addString length]) > 3) {
        return;
    }
    
    if ([currentTextField isKindOfClass:[LimitLengthField class]] && [addString containsString:@"."]) {
        return;
    }
    
    if ([currentTextField isKindOfClass:[AmountTextField class]] && [addString isEqualToString:@"."]) {
        return;
    }
    
    if ([currentTextField isKindOfClass:[AmountTextField class]] && [addString length] > 2) {
        [currentTextField setText:[DecimalUtil formatNumber:[addString intValue]]];
        self.inputString = [NSMutableString stringWithFormat:@"%@", [DecimalUtil formatNumber:[addString intValue]]];
        return;
    }
    
    if ([currentTextField isKindOfClass:[AmountTextField class]]) {
        NSMutableString *string = [[NSMutableString alloc] initWithFormat:@"%@%@", currentTextField.text, addString];
        [string replaceOccurrencesOfString:@","
                                withString:@""
                                   options:NSLiteralSearch
                                     range:NSMakeRange(0, string.length)];
        if ([string length] > AmountMaxLength) {
            return;
        }
    }
    
    
//    if (![currentTextField isKindOfClass:[AmountTextField class]] && [addString length] > 2) {
//        return;
//    }
    
    UITextPosition * start = currentTextField.selectedTextRange.start;
    NSInteger startOffset = [currentTextField offsetFromPosition:currentTextField.beginningOfDocument toPosition:currentTextField.selectedTextRange.start];
    NSInteger endOffset = [currentTextField offsetFromPosition:currentTextField.beginningOfDocument toPosition:currentTextField.selectedTextRange.end];
    NSRange offsetRange;
    if (endOffset - startOffset == 0) {
//        offsetRange = NSMakeRange(startOffset - 1, 1);
        [self.inputString insertString:addString atIndex:startOffset];
    } else {
        offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        [self.inputString replaceCharactersInRange:offsetRange withString:addString];
    }
    
    if ([currentTextField isKindOfClass:[LimitDigistField class]]) {
        if ([self.inputString containsString:@"."]) {
            int digist = ((LimitDigistField *)currentTextField).digist;
            if ([self getDigistLength:self.inputString] > digist || [self getIntLength:self.inputString] > 3) {
                self.inputString = [[NSMutableString alloc] initWithString:currentTextField.text];
                return;
            }
        } else {
            if ([self.inputString length] > 3) {
                self.inputString = [[NSMutableString alloc] initWithString:currentTextField.text];
                return;
            }
        }
    }
    
    currentTextField.text = self.inputString;
    UITextPosition *position = [currentTextField positionFromPosition:start offset:[addString length]];
//    self.currentTextField.text = [self.currentTextField.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    UITextRange *textRange = [currentTextField textRangeFromPosition:position toPosition:position];
    [currentTextField setSelectedTextRange:textRange];
    if ([currentTextField isKindOfClass:[AmountTextField class]]) {
        [((AmountTextField *)currentTextField) adjustFormat];
        self.inputString = [[NSMutableString alloc] initWithString:currentTextField.text];
    }
}

- (int)getDigistLength:(NSString *)string {
    return (int)[string length] - (int)[string rangeOfString:@"."].location - 1;
}

- (int)getIntLength:(NSString *)string {
    return (int)[string rangeOfString:@"."].location;
}

- (void)returnButtonClicked {
    if ([self.delegate respondsToSelector:@selector(keyboardReturn)]) {
        [self.delegate keyboardReturn];
    }
}

- (void)upper{
    upState = !upState;
    [self updateButtonTitle];
}

- (void)updateButtonTitle {
    UIView *view = [[self subviews] objectAtIndex:0];
    for (UIView *subview in [view subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            if (upState) {
                [button setTitle:[[button currentTitle] uppercaseString] forState:UIControlStateNormal];
            } else {
                [button setTitle:[[button currentTitle] lowercaseString] forState:UIControlStateNormal];
            }
        }
    }
}


#pragma keyboardDelegate
- (void)keyboard:(id)keyboard didClickNormalButton:(UIButton *)button {
    if ([button currentTitle] == nil || [[button currentTitle] isEqualToString:@""]) {
        //        [self.nextResponder resignFirstResponder];
        //        [self.nextResponder textsh];
        //        if ([self.nextResponder isKindOfClass:[UITextField class]]) {
        //            [(UITextField *)self.nextResponder text]
        //        }
        [self returnButtonClicked];
        [self layoutSubviews];
    } else if ([[[button currentTitle] uppercaseString]isEqualToString:@"UP"]){
        [self upper];
    } else if ([[button currentTitle] isEqualToString:@".?&"]){
        [[[self subviews] lastObject] removeFromSuperview];
        [self addKeyboard:LoginSymbolKeyboard];
    } else if ([[[button currentTitle] uppercaseString] isEqualToString:@"ABC"]){
        [[[self subviews]lastObject] removeFromSuperview];
        [self addKeyboard:LoginNumberKeyboard];
    }else {
        [self appendString:button];
    }
}

- (void)keyboard:(id)keyboard didClickDeleteButton:(UIButton *)button {
    if (self.inputString.length > 0) {
        //        [self.inputString deleteCharactersInRange:NSMakeRange(self.inputString.length - 1, 1)];
//        self.currentTextField.text = [DecimalUtil formatNumber:[self.currentTextField.text doubleValue]];
//        self.currentTextField.text = [self.currentTextField.text stringByReplacingOccurrencesOfString:@"," withString:@""];
   
        NSString *deleteString = nil;
        if ([currentTextField isKindOfClass:[AmountTextField class]]) {
            
            deleteString = [self deleteString];
            while ([deleteString isEqualToString:@","]) {
                deleteString = [self deleteString];
            }
            
            [((AmountTextField *)currentTextField) adjustFormat];
            self.inputString = [[NSMutableString alloc] initWithString:currentTextField.text];
        } else {
            deleteString = [self deleteString];
        }
        
        if (deleteString == nil) {
            return;
        }
        
        if ([self.delegate respondsToSelector:@selector(keyboard:didClickDeleteButton:string:)]) {
            [self.delegate keyboard:self didClickDeleteButton:button string:self.inputString];
        }
    }
}

- (NSString *)deleteString {
    UITextPosition * start = self.currentTextField.selectedTextRange.start;
    UITextPosition *position;
    NSInteger startOffset = [self.currentTextField offsetFromPosition:self.currentTextField.beginningOfDocument toPosition:self.currentTextField.selectedTextRange.start];
    
    NSInteger endOffset = [self.currentTextField offsetFromPosition:self.currentTextField.beginningOfDocument toPosition:self.currentTextField.selectedTextRange.end];
    if (startOffset == 0 && endOffset == 0) {
        return nil;
    }
    NSRange offsetRange;
    if (endOffset - startOffset == 0) {
        offsetRange = NSMakeRange(startOffset - 1, 1);
        position = [self.currentTextField positionFromPosition:start offset:-1];
    } else {
        offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        position = [self.currentTextField positionFromPosition:start offset:0];
    }
    NSString *deleteString = [self.inputString substringWithRange:offsetRange];
    [self.inputString deleteCharactersInRange:offsetRange];
    
    self.currentTextField.text = self.inputString;
    [self.currentTextField setSelectedTextRange:[self.currentTextField textRangeFromPosition:position toPosition:position]];
    return deleteString;
}

@end
