//
//  NSStreamDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/11/21.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "NSStreamDemoController.h"

@interface NSStreamDemoController ()<NSStreamDelegate>

@property (nonatomic,strong) NSString *filePath;

@property (nonatomic,assign) int location;

@end

@implementation NSStreamDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.filePath = NSHomeDirectory();
    self.filePath = [self.filePath stringByAppendingPathComponent:@"Documents/test_data.txt"];
    
//    [self createTestFile];
    [self inPutStreamAction];
    
}

- (void)createTestFile{
    
    NSError *error;
    NSString *msg = @"测试数据，需要的测试数据，测试数据显示。";
    bool  isSuccess = [msg writeToFile:self.filePath atomically:true encoding:NSUTF8StringEncoding error:&error];
    if (isSuccess) {
        NSLog(@"数据写入成功了");
    }else{
        NSLog(@"error is %@",error.description);
    }
    
    // 追加数据
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:self.filePath];
    [handle seekToEndOfFile];
    NSString *newMsg = @".....我将添加到末尾你处";
    NSData *data = [newMsg dataUsingEncoding:NSUTF8StringEncoding];
    [handle writeData:data];
    [handle closeFile];
}


- (void)outPutStramAction {
    
    NSString *path = @"/Users/yubo/Desktop/stream_ios.txt";
    NSOutputStream *writeStream = [[NSOutputStream alloc]initToFileAtPath:path append:true];
    
    // 手动创建文件， 如果是系统创建的话， 格式编码不一样。
    bool flag = [@"Ios----->" writeToFile:path atomically:true encoding:NSUTF8StringEncoding error:nil];
    if (flag) {
        NSLog(@"创建成功");
    }
    
    writeStream.delegate = self;
    [writeStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [writeStream open];
}


// NSInPutStream 处理   读

- (void)inPutStreamAction {
    
    NSInputStream *readStream = [[NSInputStream alloc]initWithFileAtPath:_filePath];
    [readStream setDelegate:self];
    
    // 这个runLoop就相当于死循环，一直会对这个流进行操作。
    [readStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [readStream open];
}


#pragma mark  NSStreamDelegate代理
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    switch (eventCode) {
            
        case NSStreamEventHasSpaceAvailable:{ // 写
            
            NSString *content = [NSString stringWithContentsOfFile:_filePath encoding:NSUTF8StringEncoding error:nil];
            NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
            
            NSOutputStream *writeStream = (NSOutputStream *)aStream;
            [writeStream write:data.bytes maxLength:data.length];
            [aStream close];
            
            // 用buf的还没成功
            
            //          [writeStream write:<#(nonnull const uint8_t *)#> maxLength:<#(NSUInteger)#>]; 乱码形式
            
            break;
        }
        case NSStreamEventHasBytesAvailable:{ // 读
            uint8_t buf[1024];
            NSInputStream *reads = (NSInputStream *)aStream;
            NSInteger blength = [reads read:buf maxLength:sizeof(buf)];
            if (blength != 0) {
                NSData *data = [NSData dataWithBytes:(void *)buf length:blength];
                NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"文件内容如下：----->%@",msg);
            }else{
                [aStream close];
            }
            break;
        }
        case NSStreamEventErrorOccurred:{// 错误处理
            
            NSLog(@"错误处理");
            break;
            
        }
        case NSStreamEventEndEncountered: {
            [aStream close];
            break;
        }
        case NSStreamEventNone:{// 无事件处理
            
            NSLog(@"无事件处理");
            break;
        }
        case  NSStreamEventOpenCompleted:{// 打开完成
            
            NSLog(@"打开文件");
            break;
        }
        default:
            break;
    }
}



@end
