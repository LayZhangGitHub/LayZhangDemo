//
//  ZLSignatureView.h
//  PanTest
//
//  Created by LayZhang on 2017/5/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface ZLSignatureView : GLKView

@property (assign, nonatomic) UIColor *strokeColor;
@property (assign, nonatomic) BOOL hasSignature;
@property (strong, nonatomic) UIImage *signatureImage;

- (void)erase;

@end
