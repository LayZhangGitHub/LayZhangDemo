//
//  DCommandViewController.m
//  LayZhangDemo
//
//  Created by Lay on 2019/6/4.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "DCommandViewController.h"
#import "ConCommandA.h"
#import "ConCommandB.h"
#import "ConCommandC.h"
#import "CInvoker.h"

/*
 * 请求可以抽象出来排队
 * 知道请求顺序
 * 撤销请求
 */
@interface DCommandViewController ()

@property (nonatomic, strong) CReceiver *receiver;
@property (nonatomic, strong) CInvoker *invoker;
@property (nonatomic, strong) NSMutableArray *commands;

@end

@implementation DCommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"DCommand" withLeft:[UIImage imageNamed:@"icon_back"]];
    
    self.receiver = [CReceiver new];
    self.invoker = [CInvoker new];
    self.commands = @[].mutableCopy;
    [self.commands addObject:[[ConCommandA alloc] initWithReceiver:self.receiver]];
    [self.commands addObject:[[ConCommandB alloc] initWithReceiver:self.receiver]];
    [self.commands addObject:[[ConCommandC alloc] initWithReceiver:self.receiver]];
    
    [self doCommands];
}

- (void)doCommands
{
    for (id<ICommand> command in self.commands) {
        self.invoker.command = command;
        [self.invoker doCommand];
    }
}

@end
