//
//  KeyChainDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/27.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "KeyChainDemoController.h"
#import "KeyChainUtil.h"

@interface KeyChainDemoController ()

@end

@implementation KeyChainDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)checkKeyChain {
    if (![KeyChainUtil keyChainLoad]) {
        NSLog(@"keyChain check: exist");
    }else {
        NSLog(@"keyChain check: absent");
    }
}

- (IBAction)save:(UIButton *)sender {
    [KeyChainUtil keyChainSave:[[NSUUID UUID]UUIDString]];
    NSLog(@"keyChain save success");
}

- (IBAction)load:(UIButton *)sender {
    if (![KeyChainUtil keyChainLoad]) {
        NSLog(@"keyChain load fail");
    }else {
        NSLog(@"keyChain load success: %@ ",[KeyChainUtil keyChainLoad]);
    }
}

- (IBAction)delete:(UIButton *)sender {
    [KeyChainUtil keyChainDelete];
    if (![KeyChainUtil keyChainLoad]) {
        NSLog(@"keyChain delete success ");
    }
}

@end
