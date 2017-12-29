//
//  URLSessionViewController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/12/25.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "URLSessionViewController.h"

@interface URLSessionViewController ()<NSURLSessionDelegate>

@property (nonatomic, retain) NSMutableData *allData;

@end

@implementation URLSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self sessionDelegateDemo];
}

- (void)sessionDelegateDemo {
    /** 1. 创建NSURLSessionConfiguration类的对象, 这个对象被用于创建NSURLSession类的对象. */
    NSURLSessionConfiguration *configura = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    /**
     * 2. 创建NSURLSession的对象.
     * 参数一 : NSURLSessionConfiguration类的对象.(第1步创建的对象.)
     * 参数二 : session的代理人. 如果为nil, 系统将会提供一个代理人.
     * 参数三 : 一个队列, 代理方法在这个队列中执行. 如果为nil, 系统会自动创建一系列的队列.
     * 注: 只能通过这个方法给session设置代理人, 因为在NSURLSession中delegate属性是只读的.
     */
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configura delegate:self delegateQueue:nil];
    
    /** 3. 创建URL. */
    NSURL *url = [NSURL URLWithString:@"http://c.3g.163.com/photo/api/list/0096/4GJ60096.json"];
    /** 4. 创建request. */
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    /** request请求方式为: GET. 如果是POST, 还需要设置HTTPBody属性. */
    
    
    /** 5. 创建数据类型的任务. */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    
    /** 6. 开始任务. */
    [dataTask resume];
    
    /** 7. 在session中的所有任务都完成之后, 使session失效. */
    [session finishTasksAndInvalidate];
}

#pragma mark - NSURLSessionDataDelegate
// 接收 之前
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    
    NSLog(@"before ...");
    /** a. 初始化allData属性(步骤1中设置的属性). */
    self.allData = [NSMutableData data];
    
    /** b. 让任务继续正常进行.(如果没有写这行代码, 将不会执行下面的代理方法.) */
    completionHandler(NSURLSessionResponseAllow);
}

// 接收数据， 多次调用
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"receive data...");
    /** 接收返回的数据. */
    [self.allData appendData:data];
}

// 数据加载完成
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"finished data...");
    /** 处理数据. */
    NSError *er = nil;
    id result = [NSJSONSerialization JSONObjectWithData:self.allData options:NSJSONReadingMutableContainers error:&er];
    NSLog(@"result: %@", result);
}

@end
