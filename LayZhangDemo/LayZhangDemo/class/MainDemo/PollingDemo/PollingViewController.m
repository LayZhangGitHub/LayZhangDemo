//
//  PollingViewController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/6/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PollingViewController.h"

//#import "AFHTTPRequestOperationManager.h"

#import "SubObject.h"

#import "PollingAOperation.h"
//#import "AFHTTPRequestOperationManager.h"

@interface PollingViewController ()

@property (nonatomic, assign) NSUInteger requestTime;
@property (nonatomic, strong) NSMutableDictionary *mDic;
@property (nonatomic, strong) NSArray *mArray;

@property (nonatomic, assign) BOOL *isEndPolling;



@end

@implementation PollingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"PollingDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self doPolling];
    
    [[SubObject alloc] init];
}

- (void)doPolling {
    
    @autoreleasepool {
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        PollingAOperation *operation = [[PollingAOperation alloc] init];
        [queue addOperation:operation];
        
    }

}

- (void)dealloc {
    NSLog(@"Polling Viewcontroller dealloc");
}


@end
