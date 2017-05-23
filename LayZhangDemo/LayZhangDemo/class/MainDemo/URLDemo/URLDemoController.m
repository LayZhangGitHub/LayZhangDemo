//
//  URLDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "URLDemoController.h"

@interface URLDemoController ()

@end

@implementation URLDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self urlConnectionDemo];
    [self urlSessionDemo];
    
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
    NSString *londonWeatherUrl =
    @"http://api.openweathermap.org/data/2.5/weather?q=London,uk";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:[NSURL URLWithString:londonWeatherUrl]
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
