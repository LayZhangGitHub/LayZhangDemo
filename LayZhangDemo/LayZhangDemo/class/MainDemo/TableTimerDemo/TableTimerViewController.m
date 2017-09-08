//
//  TableTimerViewController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "TableTimerViewController.h"
#import "TableTimerTableViewCell.h"

@interface TableTimerViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic, strong) NSMutableSet<NSTimer *> *timerSet;

@end

@implementation TableTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"TableTimerDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self initTableView];
//    self.timerSet = [[NSMutableSet alloc] init];
}

- (void)initTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = ZLRGB(240, 240, 240);
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    [backView addSubview:tableView];
    
    [self.view addSubview:backView];
}

#pragma mark - tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableTimerTableViewCell *cell = [TableTimerTableViewCell cellWithTableView:tableView];
//    [self.timerSet addObject:cell.timer];
    NSDictionary *item = @{@"value": @"10"};
    cell.item = item;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)dealloc {
    [DefaultNotificationCenter postNotificationName:TimerCellDeallocNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
