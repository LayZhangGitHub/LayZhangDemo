//
//  ReactiveDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/11/28.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ReactiveDemoController.h"
#import "ReactModel.h"

@interface ReactiveDemoController ()

@end

@implementation ReactiveDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    ReactModel *model = [[ReactModel alloc] init];
    
    [RACObserve(model, name) subscribeNext:^(NSString* x) {
        NSLog(@"你动了");
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        model.name  = @"mName";
    });
    
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
