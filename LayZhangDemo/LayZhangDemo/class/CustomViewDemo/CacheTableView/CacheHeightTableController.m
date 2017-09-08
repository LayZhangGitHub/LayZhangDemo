//
//  CacheHeightTableController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/24.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "CacheHeightTableController.h"
#import "AnnoucementCell.h"
#import "MessageModel.h"

@interface CacheHeightTableController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *messageArray;

@end

@implementation CacheHeightTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"CacheHeightDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self initComponent];
    [self loadMessage];
}

#pragma mark - initComponent
- (void)initComponent {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = ZLRGB(243, 245, 249);
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[AnnoucementCell class] forCellReuseIdentifier:@"AnnoucementCell"];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    [backView addSubview:tableView];
    
    [self.view addSubview:backView];
}

- (void)loadMessage {
    MessageModel *message1 = [[MessageModel alloc] init];
    message1.ID = @"1";
    message1.content1 = @"111111111";
    message1.content2 = @"111111111111111111111111111111111111";
    message1.content3 = @"111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111";

    MessageModel *message2 = [[MessageModel alloc] init];
    message2.ID = @"2";
    message2.content1 = @"2222222";
    message2.content2 = @"2";
    message2.content3 = @"22222222222222222222222222222222222222222222222222222222";

    MessageModel *message3 = [[MessageModel alloc] init];
    message3.ID = @"3";
    message3.content1 = @"333333333";
    message3.content2 = @"333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333";
    message3.content3 = @"333333333333333333333333333333333333333333333333333333333333333";

    NSArray *array = [NSArray arrayWithObjects:message1, message2, message3, nil];
    self.messageArray = array;
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    AnnoucementCell *cell = [AnnoucementCell cellWithTableView:tableView];
    
    [self configCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configCell:(AnnoucementCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO;
    cell.message = self.messageArray[indexPath.row];
    if (indexPath.row %2 == 0) {
        cell.backgroundColor = [UIColor grayColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    return 136 * SCALE;
    MessageModel *message = self.messageArray[indexPath.row];
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"AnnoucementCell"
                                          cacheByKey:message.ID
                                       configuration:^(AnnoucementCell *cell) {
                                           [self configCell:cell atIndexPath:indexPath];
                                       }];
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20 * SCALE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20 * SCALE)];
    view.backgroundColor = ZLRGB(243, 245, 249);
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *message = self.messageArray[indexPath.row];
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"AnnoucementCell"
                                                    cacheByKey:message.ID
                                                 configuration:^(AnnoucementCell *cell) {
                                                     
                                                 }];
    [[NSString stringWithFormat:@"cell Height is : %f", height] showNotice];
}



@end
