//
//  URLDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "URLDemoController.h"

@interface URLDemoController ()<NSURLSessionDelegate>

@end

@implementation URLDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self urlConnectionDemo];
    [self createNavBarWithTitle:@"urlSessionDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
//    [self urlSessionDemo];
    
//    [self sessionDelegate];
//    [self downloadTask];
    [self downloadTaskDelegate];
    
}

- (void)urlConnectionDemo {
    NSString *londonWeatherUrl =
    @"http://api.openweathermap.org/data/2.5/weather?q=London,uk";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:londonWeatherUrl]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error){
                               //处理返回的数据data
                               //1. 将data转换为JSON
                               //2. 打印内容
                               NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                          options:NSJSONReadingMutableContainers
                                                                                            error:nil];
                               
                               for (NSString *str in dictionary.allKeys) {
                                   NSLog(@"%@:%@", str, dictionary[str]);
                               }
                           }];
}


- (void)urlSessionDemo {
    [self sessionGet];
    [self sessionPost];
}

- (void)sessionGet {
    // GET
    NSURL *londonWeatherUrl = [NSURL URLWithString:@"http://www.daka.com/login?username=daka&pwd=123"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:londonWeatherUrl
           completionHandler:^(NSData *data,
                               NSURLResponse *response,
                               NSError *error){
               //处理数据
               NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:NSJSONReadingMutableContainers
                                                                            error:nil];
               
               for (NSString *str in dictionary.allKeys) {
                   NSLog(@"%@:%@", str, dictionary[str]);
               }
           }];
    
    [task resume];
    //    [task cancel];
}

- (void)sessionPost {
    // POST
    NSURL *url = [NSURL URLWithString:@"http://www.daka.com/login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"username=daka&pwd=123" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task =
    [session dataTaskWithRequest:request
               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                   NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data
                                                                options:kNilOptions
                                                                  error:nil]);
               }];
    [task resume];
}


- (void)sessionDelegate {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:self
                                                     delegateQueue:[[NSOperationQueue alloc] init]];
    
    // 创建任务(因为要使用代理方法,就不需要block方式的初始化了)
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.daka.com/login?userName=daka&pwd=123"]]];
    NSURL *url = [NSURL URLWithString:@"http://www.daka.com/login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"username=daka&pwd=123" dataUsingEncoding:NSUTF8StringEncoding];

    NSURLSessionTask *task =
    [session dataTaskWithRequest:request];
    
    // 启动任务
    [task resume];
}

#pragma mark - urlsession delegate
// 1.接收到服务器的响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    // 允许处理服务器的响应，才会继续接收服务器返回的数据
    NSLog(@"receive response");
    completionHandler(NSURLSessionResponseAllow);
}

// 2.接收到服务器的数据（可能调用多次）
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    // 处理每次接收的数据
    NSLog(@"handle response");
}

// 3.请求成功或者失败（如果失败，error有值）
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    // 请求完成,成功或者失败的处理
    if (error) {
        NSLog(@"err");
    } else {
        NSLog(@"complete");
    }
}

- (void)downloadTask {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://www.daka.com/resources/image/icon.png"] ;
    NSURLSessionDownloadTask *task =
    [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        // location是沙盒中tmp文件夹下的一个临时url,文件下载后会存到这个位置,由于tmp中的文件随时可能被删除,所以我们需要自己需要把下载的文件挪到需要的地方
        NSLog(@"%@", location.absoluteString);
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        // 剪切文件
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
    }];
    // 启动任务
    [task resume];
}

- (void)downloadTaskDelegate {
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:self
                             delegateQueue:[[NSOperationQueue alloc] init]];
    
    NSURLSessionTask *task =
    [session downloadTaskWithURL:[NSURL URLWithString:@"http://www.daka.com/resources/image/icon.png"]];
//    [session downloadTaskWithURL:<#(nonnull NSURL *)#>];
    
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURL *url = [NSURL URLWithString:@"http://www.daka.com/resources/image/icon.png"] ;
//    NSURLSessionDownloadTask *task =
//    [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        // location是沙盒中tmp文件夹下的一个临时url,文件下载后会存到这个位置,由于tmp中的文件随时可能被删除,所以我们需要自己需要把下载的文件挪到需要的地方
//        NSLog(@"%@", location.absoluteString);
//        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
//        // 剪切文件
//        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
//    }];
    // 启动任务
    [task resume];
}


// 每次写入调用(会调用多次)
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    // 可在这里通过已写入的长度和总长度算出下载进度
    CGFloat progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite; NSLog(@"%f",progress);
    NSLog(@"%f", progress);
}

// 下载完成调用
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    // location还是一个临时路径,需要自己挪到需要的路径(caches下面)
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:filePath] error:nil];
    NSLog(@"...");
}

// 任务完成调用
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
//    
//}
@end
