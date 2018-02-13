//
//  MyView.m
//  LayZhangDemo
//
//  Created by LayZhang on 2018/1/10.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "MyView.h"
#import <OpenGLES/ES2/gl.h>
#import <AVFoundation/AVFoundation.h>

@interface MyView ()
{
    CVOpenGLESTextureCacheRef _videoTextureCache;
    CVOpenGLESTextureRef _videoTexture;
}

@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic , strong) EAGLContext* myContext;
@property (nonatomic , strong) CAEAGLLayer* myEagLayer;
@property (nonatomic , assign) GLuint       myProgram;

@property (nonatomic , assign) GLuint myColorRenderBuffer;
@property (nonatomic , assign) GLuint myColorFrameBuffer;

@property (nonatomic, strong) NSTimer *timer;
@end

static float radian = 10;
@implementation MyView


+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (instancetype)init {
    if (self = [super init]) {
        
        [self setupCache];
        [self captureDemo];
        [self setupLayer];
        
        //    [self setupContext];
        
        [self destoryRenderAndFrameBuffer];
        
        [self setupRenderBuffer];
        
        [self setupFrameBuffer];
    }
    return self;
}

- (void)layoutSubviews {
    
    
//    [self startTime];
}

//- (void)startTime {
//    if (!self.timer) {
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(render) userInfo:nil repeats:YES];
//    }
//}

- (void)render {
    glClearColor(0, 1.0, 0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    
    CGFloat scale = [[UIScreen mainScreen] scale]; //获取视图放大倍数，可以把scale设置为1试试
    glViewport(self.frame.origin.x * scale, self.frame.origin.y * scale, self.frame.size.width * scale, self.frame.size.height * scale); //设置视口大小
    
    //读取文件路径
    NSString* vertFile = [[NSBundle mainBundle] pathForResource:@"shaderv" ofType:@"vsh"];
    NSString* fragFile = [[NSBundle mainBundle] pathForResource:@"shaderf" ofType:@"fsh"];
    
    //加载shader
    self.myProgram = [self loadShaders:vertFile frag:fragFile];
    
    //链接
    glLinkProgram(self.myProgram);
    GLint linkSuccess;
    glGetProgramiv(self.myProgram, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) { //连接错误
        GLchar messages[256];
        glGetProgramInfoLog(self.myProgram, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"error%@", messageString);
        return ;
    }
    else {
        NSLog(@"link ok");
        glUseProgram(self.myProgram); //成功便使用，避免由于未使用导致的的bug
    }
    
    
    
    //前三个是顶点坐标， 后面两个是纹理坐标
    GLfloat attrArr[] =
    {
        0.5f, -0.5f, -1.0f,     1.0f, 0.0f, // 右下
        -0.5f, 0.5f, -1.0f,     0.0f, 1.0f, // 左上
        -0.5f, -0.5f, -1.0f,    0.0f, 0.0f, // 左下
        0.5f, 0.5f, -1.0f,      1.0f, 1.0f, // 右上
        -0.5f, 0.5f, -1.0f,     0.0f, 1.0f, // 左上
        0.5f, -0.5f, -1.0f,     1.0f, 0.0f, // 右下
    };
    
    GLuint attrBuffer;
    glGenBuffers(1, &attrBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, attrBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(attrArr), attrArr, GL_DYNAMIC_DRAW);
    
    GLuint position = glGetAttribLocation(self.myProgram, "position");
    glVertexAttribPointer(position, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, NULL);
    glEnableVertexAttribArray(position);
    
    GLuint textCoor = glGetAttribLocation(self.myProgram, "textCoordinate");
    glVertexAttribPointer(textCoor, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (float *)NULL + 3);
    glEnableVertexAttribArray(textCoor);
    
    //加载纹理
//    [self setupTexture:@"Demo"];
    
    //获取shader里面的变量，这里记得要在glLinkProgram后面，后面，后面！
    GLuint rotate = glGetUniformLocation(self.myProgram, "rotateMatrix");
    
    radian ++;
    
    float radians = radian * 3.14159f / 180.0f;
    float s = sin(radians);
    float c = cos(radians);
    
    //z轴旋转矩阵
    GLfloat zRotation[16] = { //
        c, -s, 0, 0.2, //
        s, c, 0, 0,//
        0, 0, 1.0, 0,//
        0.0, 0, 0, 1.0//
    };
    
    //设置旋转矩阵
    glUniformMatrix4fv(rotate, 1, GL_FALSE, (GLfloat *)&zRotation[0]);
    
    glDrawArrays(GL_TRIANGLES, 0, 6);
    
    [self.myContext presentRenderbuffer:GL_RENDERBUFFER];
}

/**
 *  c语言编译流程：预编译、编译、汇编、链接
 *  glsl的编译过程主要有glCompileShader、glAttachShader、glLinkProgram三步；
 *  @param vert 顶点着色器
 *  @param frag 片元着色器
 *
 *  @return 编译成功的shaders
 */
- (GLuint)loadShaders:(NSString *)vert frag:(NSString *)frag {
    GLuint verShader, fragShader;
    GLint program = glCreateProgram();
    
    //编译
    [self compileShader:&verShader type:GL_VERTEX_SHADER file:vert];
    [self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:frag];
    
    glAttachShader(program, verShader);
    glAttachShader(program, fragShader);
    
    
    //释放不需要的shader
    glDeleteShader(verShader);
    glDeleteShader(fragShader);
    
    return program;
}

- (void)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file {
    //读取字符串
    NSString* content = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    const GLchar* source = (GLchar *)[content UTF8String];
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
}



- (void)setupLayer
{
    self.myEagLayer = (CAEAGLLayer*) self.layer;
    //设置放大倍数
    [self setContentScaleFactor:[[UIScreen mainScreen] scale]];
    
    // CALayer 默认是透明的，必须将它设为不透明才能让其可见
    self.myEagLayer.opaque = YES;
    
    // 设置描绘属性，在这里设置不维持渲染内容以及颜色格式为 RGBA8
    self.myEagLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
}

- (void)setupRenderBuffer {
    GLuint buffer;
    glGenRenderbuffers(1, &buffer);
    self.myColorRenderBuffer = buffer;
    glBindRenderbuffer(GL_RENDERBUFFER, self.myColorRenderBuffer);
    // 为 颜色缓冲区 分配存储空间
    [self.myContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.myEagLayer];
}


- (void)setupFrameBuffer {
    GLuint buffer;
    glGenFramebuffers(1, &buffer);
    self.myColorFrameBuffer = buffer;
    // 设置为当前 framebuffer
    glBindFramebuffer(GL_FRAMEBUFFER, self.myColorFrameBuffer);
    // 将 _colorRenderBuffer 装配到 GL_COLOR_ATTACHMENT0 这个装配点上
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                              GL_RENDERBUFFER, self.myColorRenderBuffer);
}


- (void)destoryRenderAndFrameBuffer
{
    glDeleteFramebuffers(1, &_myColorFrameBuffer);
    self.myColorFrameBuffer = 0;
    glDeleteRenderbuffers(1, &_myColorRenderBuffer);
    self.myColorRenderBuffer = 0;
}




- (GLuint)setupTexture:(NSString *)fileName {
    // 1获取图片的CGImageRef
    CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage;
    if (!spriteImage) {
        NSLog(@"Failed to load image %@", fileName);
        exit(1);
    }
    
    // 2 读取图片的大小
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
    
    GLubyte * spriteData = (GLubyte *) calloc(width * height * 4, sizeof(GLubyte)); //rgba共4个byte
    
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4,
                                                       CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    
    // 3在CGContextRef上绘图
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    
    CGContextRelease(spriteContext);
    
    // 4绑定纹理到默认的纹理ID（这里只有一张图片，故而相当于默认于片元着色器里面的colorMap，如果有多张图不可以这么做）
    //    glBindTexture(GL_TEXTURE_2D, 0);
    
    
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    float fw = width, fh = height;
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, fw, fh, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    
    glBindTexture(GL_TEXTURE_2D, 0);
    
    free(spriteData);
    
    return 0;
}



///////


- (void)setupCache {
    self.myContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.myContext) {
        NSLog(@"Failed to create ES context");
    }
    
    CVReturn err = CVOpenGLESTextureCacheCreate(kCFAllocatorDefault, NULL, _myContext, NULL, &_videoTextureCache);
    if (err) {
        NSLog(@"Error at CVOpenGLESTextureCacheCreate %d", err);
        return;
    }
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
    
    CVReturn err;
    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    size_t width = CVPixelBufferGetWidth(pixelBuffer);
    size_t height = CVPixelBufferGetHeight(pixelBuffer);
    
    if (!_videoTextureCache)
    {
        NSLog(@"No video texture cache");
        return;
    }
    
    err = CVOpenGLESTextureCacheCreateTextureFromImage (kCFAllocatorDefault,
                                                        _videoTextureCache,
                                                        pixelBuffer,
                                                        NULL, // texture attributes
                                                        GL_TEXTURE_2D,
                                                        GL_RGBA, // opengl format
                                                        (int)width,
                                                        (int)height,
                                                        GL_RGBA, // native iOS format
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
    
    
    
    [self render];
}

- (void)captureOutput:(AVCaptureOutput *)output didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    NSLog(@"dropped...");
}

@end
