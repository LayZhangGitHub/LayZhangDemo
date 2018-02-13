//
//  AVFoundation04Controller.m
//  LayZhangDemo
//
//  Created by LayZhang on 2018/2/13.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "AVFoundation04Controller.h"
#import <AVFoundation/AVFoundation.h>

@interface AVFoundation04Controller ()<AVCaptureVideoDataOutputSampleBufferDelegate> {
    AVAssetWriter *vedioWriter;
    AVAssetWriterInput *vedioWriteInput;
    AVAssetWriterInputPixelBufferAdaptor *adaptor;
}

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) UIImageView *showView;



@end

@implementation AVFoundation04Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithTitle:@"AVFoundation04" withLeft:[UIImage imageNamed:@"icon_back"]];
    self.showView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    [self.view addSubview:self.showView];
    
//    [self captureDemo];
//    [self initWrite];
    
    [self initRead];
}

- (void)initRead {
    NSString *betaCompressionDirectory = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents/Movie.mp4"];
    AVURLAsset *inputAsset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:betaCompressionDirectory] options:nil];
    NSError *err;
    AVAssetReader *assetReader = [AVAssetReader assetReaderWithAsset:inputAsset error:&err];
    
    if (err) {
        NSLog(@"%@", err);
    }
    
    NSMutableDictionary *outputSettings = [NSMutableDictionary dictionary];
//    if ([GPUImageContext supportsFastTextureUpload]) {
//        [outputSettings setObject:@(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange) forKey:(id)kCVPixelBufferPixelFormatTypeKey];
//        isFullYUVRange = YES;
//    }
//    else {
        [outputSettings setObject:@(kCVPixelFormatType_32BGRA) forKey:(id)kCVPixelBufferPixelFormatTypeKey];
//        isFullYUVRange = NO;
//    }
    
    // Maybe set alwaysCopiesSampleData to NO on iOS 5.0 for faster video decoding
    AVAssetReaderTrackOutput *readerVideoTrackOutput = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:[[inputAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] outputSettings:outputSettings];
    readerVideoTrackOutput.alwaysCopiesSampleData = NO;
    [assetReader addOutput:readerVideoTrackOutput];
    
//    NSArray *vedioTracks = [inputAsset tracksWithMediaType:AVMediaTypeVideo];
//    NSLog(@"%d", vedioTracks.count);
//    AVAssetTrack *vedioTrack =[vedioTracks objectAtIndex:0];
//    BOOL shouldRecordAudioTrack = (([audioTracks count] > 0) && (self.audioEncodingTarget != nil) );
//    AVAssetReaderTrackOutput *readerAudioTrackOutput = nil;
//
//    NSMutableDictionary *options = [NSMutableDictionary dictionary];
//    [options setObject:@(kCVPixelFormatType_32BGRA) forKey:(id)kCVPixelBufferPixelFormatTypeKey];
//    AVAssetReaderTrackOutput *videoReaderOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:vedioTrack outputSettings:options];
//
//    [assetReader addOutput:videoReaderOutput];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        BOOL issuccess = [assetReader startReading];
        if (issuccess) {
            NSLog(@"%@", [assetReader error]);
        } else {
            NSLog(@".....");
        }
        
        while ([assetReader status] == AVAssetReaderStatusReading) {
            
            NSLog(@"%f", [[inputAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0].nominalFrameRate);
            
            
            // 读取 video sample
            CMSampleBufferRef sampleBuffer = [readerVideoTrackOutput copyNextSampleBuffer];
            CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
            
            UIImage *image = [self uiImageFromPixelBuffer:pixelBuffer];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.showView setImage:image];
            });
            //        [self.delegate mMoveDecoder:self onNewVideoFrameReady:videoBuffer];
//            sleep(1);
            // 根据需要休眠一段时间；比如上层播放视频时每帧之间是有间隔的,这里的 sampleInternal 我设置为0.001秒
            //        [NSThread sleepForTimeInterval:sampleInternal];
        }
    });
   

}

- (void)initWrite {
    CGSize size = CGSizeMake(480, 320);
    
    NSString *betaCompressionDirectory = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents/Movie.mp4"];
    
    NSError *error = nil;

    unlink([betaCompressionDirectory UTF8String]);
    
    
    //----initialize compression engine
    vedioWriter = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:betaCompressionDirectory]
                                            fileType:AVFileTypeQuickTimeMovie
                                               error:&error];
    
    
    if(error)
        NSLog(@"error = %@", [error localizedDescription]);
    
    NSDictionary *videoCompressionProps = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [NSNumber numberWithDouble:128.0*1024.0],AVVideoAverageBitRateKey,
                                           nil ];
    
    
    
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264, AVVideoCodecKey,
                                   [NSNumber numberWithInt:size.width], AVVideoWidthKey,
                                   [NSNumber numberWithInt:size.height],AVVideoHeightKey,videoCompressionProps, AVVideoCompressionPropertiesKey, nil];

    vedioWriteInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
    NSParameterAssert(vedioWriteInput);
    
    
    vedioWriteInput.expectsMediaDataInRealTime = YES;
    
    
    NSDictionary *sourcePixelBufferAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [NSNumber numberWithInt:kCVPixelFormatType_32ARGB], kCVPixelBufferPixelFormatTypeKey, nil];
    
    
    
    adaptor =
    [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:vedioWriteInput
                                                                     sourcePixelBufferAttributes:sourcePixelBufferAttributesDictionary];
    
    NSParameterAssert(vedioWriteInput);
    NSParameterAssert([vedioWriter canAddInput:vedioWriteInput]);
    
    
    if ([vedioWriter canAddInput:vedioWriteInput])
        NSLog(@"I can add this input");
    else
        NSLog(@"i can't add this input");
    
    
    
    // Add the audio input
    
//    AudioChannelLayout acl;
//
//    bzero( &acl, sizeof(acl));
//
//    acl.mChannelLayoutTag = kAudioChannelLayoutTag_Mono;
    
    
    
//    NSDictionary* audioOutputSettings = nil;
    
    //    audioOutputSettings = [ NSDictionary dictionaryWithObjectsAndKeys:
    
    //                           [ NSNumber numberWithInt: kAudioFormatAppleLossless ], AVFormatIDKey,
    
    //                           [ NSNumber numberWithInt: 16 ], AVEncoderBitDepthHintKey,
    
    //                           [ NSNumber numberWithFloat: 44100.0 ], AVSampleRateKey,
    
    //                           [ NSNumber numberWithInt: 1 ], AVNumberOfChannelsKey,
    
    //                           [ NSData dataWithBytes: &acl length: sizeof( acl ) ], AVChannelLayoutKey,
    
    //                           nil ];
    
//    audioOutputSettings = [ NSDictionary dictionaryWithObjectsAndKeys:
//
//                           [ NSNumber numberWithInt: kAudioFormatMPEG4AAC ], AVFormatIDKey,
//
//                           [ NSNumber numberWithInt:64000], AVEncoderBitRateKey,
//
//                           [ NSNumber numberWithFloat: 44100.0 ], AVSampleRateKey,
//
//                           [ NSNumber numberWithInt: 1 ], AVNumberOfChannelsKey,
//
//                           [ NSData dataWithBytes: &acl length: sizeof( acl ) ], AVChannelLayoutKey,
//
//                           nil ];
//
//
//
//    audioWriterInput = [[AVAssetWriterInput
//
//                         assetWriterInputWithMediaType: AVMediaTypeAudio
//
//                         outputSettings: audioOutputSettings ] retain];
//
//
//
//    audioWriterInput.expectsMediaDataInRealTime = YES;
    
    // add input
    
//    [videoWriter addInput:audioWriterInput];
    
    [vedioWriter addInput:vedioWriteInput];
    
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

static int frame = 0;
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    
    CMTime lastSampleTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
    
    if(frame == 0 && vedioWriter.status != AVAssetWriterStatusWriting) {
        [vedioWriter startWriting];
        [vedioWriter startSessionAtSourceTime:lastSampleTime];
    }
    
    if(vedioWriter.status > AVAssetWriterStatusWriting ) {
        
        NSLog(@"Warning: writer status is %d", vedioWriter.status);
        
        if( vedioWriter.status == AVAssetWriterStatusFailed )
            
            NSLog(@"Error: %@", vedioWriter.error);
        
        return;
        
    }
    
    if ([vedioWriteInput isReadyForMoreMediaData])
        
        if( ![vedioWriteInput appendSampleBuffer:sampleBuffer] )
            NSLog(@"Unable to write to video input");
        else
            NSLog(@"already write vidio");
    
    
    if (frame == 500)
    {
        [vedioWriteInput markAsFinished];
        [vedioWriter finishWriting];
    }
    
    NSLog(@"%d", frame);
    
    frame ++;
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
