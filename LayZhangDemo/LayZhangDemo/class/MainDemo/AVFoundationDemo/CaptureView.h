//
//  CaptureView.h
//  LayZhangDemo
//
//  Created by LayZhang on 2018/1/11.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaptureView : UIView

- (void)displayPixelBuffer:(CVPixelBufferRef)pixelBuffer;

@end
