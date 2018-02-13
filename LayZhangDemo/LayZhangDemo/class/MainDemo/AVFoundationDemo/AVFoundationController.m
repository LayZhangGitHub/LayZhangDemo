//
//  AVFoundationController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2018/1/9.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "AVFoundationController.h"
#import <AVFoundation/AVFoundation.h>
#import <GLKit/GLKit.h>

@interface AVFoundationController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic , strong) EAGLContext* mContext;
@property (nonatomic , strong) GLKBaseEffect* mEffect;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) AVCaptureSession *session;
@end

@implementation AVFoundationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"AVFoundation" withLeft:[UIImage imageNamed:@"icon_back"]];
//    [self setupConfig];
    NSNumber *n;
    NSInteger i = [n integerValue];
    NSLog(@"%ld", (long)i);
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.imageView];
    [self demo];
    
    
    
}

//- (void)setupConfig {
//    //新建OpenGLES 上下文
//    self.mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2]; //2.0，还有1.0和3.0
//    GLKView* view = (GLKView *)self.view; //storyboard记得添加
//    view.context = self.mContext;
//    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;  //颜色缓冲区格式
//    [EAGLContext setCurrentContext:self.mContext];
//}
//
//- (void)uploadVertexArray {
//    //顶点数据，前三个是顶点坐标，后面两个是纹理坐标
//    GLfloat vertexData[] =
//    {
//        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
//        0.5, 0.5, -0.0f,    1.0f, 1.0f, //右上
//        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
//
//        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
//        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
//        -0.5, -0.5, 0.0f,   0.0f, 0.0f, //左下
//    };
//
//    //顶点数据缓存
//    GLuint buffer;
//    glGenBuffers(1, &buffer);
//    glBindBuffer(GL_ARRAY_BUFFER, buffer);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexData), vertexData, GL_STATIC_DRAW);
//
//    glEnableVertexAttribArray(GLKVertexAttribPosition); //顶点数据缓存
//    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);
//    glEnableVertexAttribArray(GLKVertexAttribTexCoord0); //纹理
//    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);
//}
//
//- (void)uploadTexture {
//    //纹理贴图
//    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"for_test" ofType:@"jpg"];
//    NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:@(1), GLKTextureLoaderOriginBottomLeft, nil];//GLKTextureLoaderOriginBottomLeft 纹理坐标系是相反的
//    GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
//    //着色器
//    self.mEffect = [[GLKBaseEffect alloc] init];
//    self.mEffect.texture2d0.enabled = GL_TRUE;
//    self.mEffect.texture2d0.name = textureInfo.name;
//}

- (void)demo {
    dispatch_queue_t sessionQueue = dispatch_queue_create( "com.apple.sample.sessionmanager.capture", DISPATCH_QUEUE_SERIAL );
    dispatch_queue_t videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
    
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    device.activeVideoMinFrameDuration = CMTimeMake(1, 15);
    
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if ([session canAddInput:input]) {
        [session addInput:input];
    }
    
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc]init];
//    [output setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
    [output setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]
                                                             forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
    [output setSampleBufferDelegate:self queue:videoDataOutputQueue];
    
    [output setAlwaysDiscardsLateVideoFrames:YES];
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
    
    AVCaptureConnection *connection = [output connectionWithMediaType:AVMediaTypeVideo];
    [connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    

    
    
//    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:session];
//
//    CALayer *layer= self.view.layer;
//    layer.masksToBounds=YES;
//
//    captureVideoPreviewLayer.frame=layer.bounds;
//    captureVideoPreviewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//填充模式
    //将视频预览层添加到界面中
    //[layer addSublayer:_captureVideoPreviewLayer];
//    [layer insertSublayer:captureVideoPreviewLayer below:self.focusCursor.layer];
    
    
    
//    NSError *e;
//    if ([device lockForConfiguration:&e]) {
//        [device setActiveVideoMaxFrameDuration:CMTimeMake(1, 30)];
//        [device setActiveVideoMinFrameDuration:CMTimeMake(1, 30)];
//        [device unlockForConfiguration];
//    } else {
//        NSLog(@"videoDevice lockForConfiguration returned error %@", e);
//    }
    
//    output.minFrameDuration = CMTimeMake(1, 15);
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [session startRunning];
//    });
//    dispatch_sync( sessionQueue, ^{
        [session startRunning];
//    });
    
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    UIImage *image = [self uiImageFromPixelBuffer:pixelBuffer];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.imageView setImage:image];
    });
    
//    self.mEffect.texture2d0.name = CVOpenGLESTextureGetName(CVOpenGLESTextureRef  _Nonnull image);
//    NSLog(@"%@", sampleBuffer);
    NSLog(@"......");
    
}

- (void)captureOutput:(AVCaptureOutput *)output didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    NSLog(@"..... drop");
}

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
