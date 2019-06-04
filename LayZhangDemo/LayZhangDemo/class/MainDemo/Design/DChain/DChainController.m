//
//  DChainController.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "DChainController.h"

#import "ConChainA.h"
#import "ConChainB.h"
#import "ConChainC.h"

@interface DChainController ()

@end

@implementation DChainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ConChainA *chainA = [ConChainA new];
    ConChainB *chainB = [ConChainB new];
    ConChainC *chainC = [ConChainC new];
    chainA.nextHandler = chainB;
    chainB.nextHandler = chainC;
    
    [chainA handleRequest:@"ConChainA"];
    [chainA handleRequest:@"ConChainB"];
    [chainA handleRequest:@"ConChainC"];
    [chainA handleRequest:@"ConChainD"];
}

@end
