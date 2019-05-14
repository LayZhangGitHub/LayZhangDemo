//
//  EncodingDemoController.m
//  LayZhangDemo
//
//  Created by Lay on 2019/4/30.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "EncodingDemoController.h"
#import "CFounctionDemo.h"

@interface EncodingDemoController ()

@end

typedef struct _struct {
    short a;
    long long b;
    unsigned long long c;
} Struct;

@implementation EncodingDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSObject *o = [NSObject new];
//    Class *class = o.class;
    NSLog(@"%s", @encode(NSObject *));
    void *returnPtr = NULL;
    [CFounctionDemo objectWithCValue:returnPtr forType:@encode(Struct)];
}



@end
