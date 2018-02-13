//
//  AVFoundation02Controller.m
//  LayZhangDemo
//
//  Created by LayZhang on 2018/1/10.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "AVFoundation02Controller.h"
#import <AVFoundation/AVFoundation.h>
#import <OpenGLES/ES2/glext.h>
#import "CaptureView.h"

@interface AVFoundation02Controller ()<AVCaptureVideoDataOutputSampleBufferDelegate> {
    CVOpenGLESTextureCacheRef _videoTextureCache;
    CVOpenGLESTextureRef _videoTexture;
}

@property (nonatomic, strong) EAGLContext *context;
@property (nonatomic, strong) AVCaptureSession *session;

//@property (nonatomic, strong) CaptureView *captureView;

@end

@implementation AVFoundation02Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithTitle:@"AVFoundation02" withLeft:[UIImage imageNamed:@"icon_back"]];
//    self.captureView = [[CaptureView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:self.captureView];
    
    [self setupCache];
    [self captureDemo];
}

- (void)setupCache {
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.context];
    
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    if (_videoTextureCache) {
        return;
    }
    
    CVReturn err = CVOpenGLESTextureCacheCreate(kCFAllocatorDefault, NULL, _context, NULL, &_videoTextureCache);
    if (err) {
        NSLog(@"Error at CVOpenGLESTextureCacheCreate %d", err);
        return;
    }

}

- (void)loadShader {
    
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
        [output setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
//    [output setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]
//                                                         forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [session startRunning];
    });
    
}


- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    CVReturn err;
    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    size_t width = CVPixelBufferGetWidth(pixelBuffer);
    size_t height = CVPixelBufferGetHeight(pixelBuffer);
    
    if (!_videoTextureCache)
    {
        NSLog(@"No video texture cache");
        return;
    }
    NSLog(@".....ppp");
    if ([EAGLContext currentContext] != _context) {
        [EAGLContext setCurrentContext:_context];
    }
    
    glActiveTexture(GL_TEXTURE0);
    err = CVOpenGLESTextureCacheCreateTextureFromImage (kCFAllocatorDefault,
                                                        _videoTextureCache,
                                                        pixelBuffer,
                                                        NULL, // texture attributes
                                                        GL_TEXTURE_2D,
                                                        GL_RGBA, // opengl format
                                                        (int)width,
                                                        (int)height,
                                                        GL_BGRA, // native iOS format
                                                        GL_UNSIGNED_BYTE,
                                                        0,
                                                        &_videoTexture);
    if (err) {
        NSAssert(NO, @"Error at CVOpenGLESTextureCacheCreateTextureFromImage %d", err);
    }
    
    glBindTexture(CVOpenGLESTextureGetTarget(_videoTexture), CVOpenGLESTextureGetName(_videoTexture));
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, CVOpenGLESTextureGetName(_videoTexture), 0);
    
    if ([EAGLContext currentContext] == _context) {
        [_context presentRenderbuffer:GL_RENDERBUFFER];
    }
}

- (void)captureOutput:(AVCaptureOutput *)output didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    NSLog(@"dropped...");
}



@end
