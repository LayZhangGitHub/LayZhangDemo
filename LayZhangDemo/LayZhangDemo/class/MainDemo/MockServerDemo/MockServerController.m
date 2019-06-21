//
//  MockServerController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/12/22.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MockServerController.h"
#import "OHHTTPStubs.h"
#import "OHPathHelpers.h"

@interface MockServerController ()

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIImageView *testImage;

@end

@implementation MockServerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"mockserver" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self mockServerDemo];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self request];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImage *image = [self gimage];
        self.testImage = [UIImageView new];
        self.testImage.frame = CGRectMake(180, 150, 100, 100);
        self.testImage.contentMode = UIViewContentModeScaleAspectFit;
        self.testImage.clipsToBounds = YES;
        self.testImage.backgroundColor = [UIColor redColor];
        [self.view addSubview:self.testImage];
        [self.testImage setImage:image];
    });
}

- (void)mockServerDemo {
//    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
//        return [request.URL.host isEqualToString:@"www.baidu.com"];
//    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
//        // Stub it with our "wsresponse.json" stub file (which is in same bundle as self)
//        NSString* fixture = OHPathForFile(@"google.json", self.class);
//        return [OHHTTPStubsResponse responseWithFileAtPath:fixture
//                                                statusCode:200 headers:@{@"Content-Type":@"application/json"}];
//    }];
}

- (UIImage *)gimage
{
    UIGraphicsBeginImageContextWithOptions(self.webView.bounds.size, YES, 0);
    self.webView.layer.backgroundColor = [UIColor clearColor].CGColor;
    [self.webView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

- (void)request {
    
    NSString *url = @"http://www.baidu.com";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"POST";
//    NSHTTPURLResponse *response = nil;
    [NSURLConnection connectionWithRequest:request delegate:self];
//    NSURLConnection *con = [NSURLConnection connectionWithRequest:connectionRequest
//                                                         delegate:self];
    
//    [self.webView.layer renderInContext:nil];
    
   
    
//    NSData *data = [NSURLConnection sendSynchronousRequest:request
//                                         returningResponse:&response
//                                                     error:nil];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    NSLog(@"%@",dict);
    
//    NSString *url = @"http://www.baidu.com";
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
//    request.HTTPMethod = @"POST";
//    NSHTTPURLResponse *response = nil;
//    NSData *data = [NSURLConnection sendSynchronousRequest:request
//                          returningResponse:&response
//                                      error:nil];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    NSLog(@"%@",dict);
    
    
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSString *url = @"https://www.baidu.com";
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
//    request.HTTPMethod = @"POST";
//    request.allHTTPHeaderFields = @{@"Accept": @"application/json",@"Content-Type": @"application/json"};
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//        NSLog(@"%@",dict);
//
//    }];
//
//    [dataTask resume];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(100, 900, 100, 1000)];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"1");
//    [[self client] URLProtocol:self didLoadData:data];
//    [self appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"2");
//    [[self client] URLProtocol:self didFailWithError:error];
//    [self setConnection:nil];
//    [self setData:nil];
//    [self setResponse:nil];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"3");
//    [self setResponse:response];
//    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];  // We cache ourselves.
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"4");
//    [[self client] URLProtocolDidFinishLoading:self];
//
//    NSString *cachePath = [self cachePathForRequest:[self request]];
//    RNCachedData *cache = [RNCachedData new];
//    [cache setResponse:[self response]];
//    [cache setData:[self data]];
//    [NSKeyedArchiver archiveRootObject:cache toFile:cachePath];
//
//    [self setConnection:nil];
//    [self setData:nil];
//    [self setResponse:nil];
}

@end
