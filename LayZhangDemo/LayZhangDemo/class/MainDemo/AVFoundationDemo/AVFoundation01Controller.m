//
//  AVFoundation01Controller.m
//  LayZhangDemo
//
//  Created by LayZhang on 2018/1/10.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "AVFoundation01Controller.h"
#import <AVFoundation/AVFoundation.h>

/**
 使用 AVMediaTypeVideo 获取 video
 CMSampleBufferRef --> image
 只是demo 这样做效率很低，基本不会这么处理
 */
@interface AVFoundation01Controller ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) UIImageView *showView;
@end

@implementation AVFoundation01Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithTitle:@"AVFoundation01" withLeft:[UIImage imageNamed:@"icon_back"]];
    self.showView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    [self.view addSubview:self.showView];
    
    [self captureDemo];
}

- (void)captureDemo {
    
    // 1. 初始化session
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    
    // 2. 输入设备 摄像头
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if ([session canAddInput:input]) {
        [session addInput:input];
    }
    
    // 3. 输出
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    //    [output setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
    [output setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]
                                                         forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
    dispatch_queue_t videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
    [output setSampleBufferDelegate:self queue:videoDataOutputQueue];
    
    // 如果有延迟，是否丢掉这一帧
    [output setAlwaysDiscardsLateVideoFrames:YES];
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
    
    // 4. 旋转屏幕
    AVCaptureConnection *connection = [output connectionWithMediaType:AVMediaTypeVideo];
    [connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    
    // 5. 启动
    [session startRunning];
}


- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    NSLog(@"output capture");
    
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    UIImage *image = [self uiImageFromPixelBuffer:pixelBuffer];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.showView setImage:image];
    });
}

- (void)captureOutput:(AVCaptureOutput *)output didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    NSLog(@"dropped...");
}

// 只是demo 这样做效率很低，基本不会这么处理
// CoreVedio 有针对 vedio 的缓存可以优化
- (UIImage*)uiImageFromPixelBuffer:(CVPixelBufferRef)p {
    CIImage* ciImage = [CIImage imageWithCVPixelBuffer:p];
    
    CIContext* context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}];
    
    CGRect rect = CGRectMake(0, 0, CVPixelBufferGetWidth(p), CVPixelBufferGetHeight(p));
    CGImageRef videoImage = [context createCGImage:ciImage fromRect:rect];
    
    UIImage* image = [UIImage imageWithCGImage:videoImage];
    CGImageRelease(videoImage);
    
    return image;
}

@end
