//
//  BaseTableController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseTableController.h"
#import "MJRefresh.h"
#import "BaseTableCell.h"

@interface BaseTableController ()

@end

@implementation BaseTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addContentTableView];
    [self addRefreshAction];
    [self showNavigationBar];
}

- (void)addContentTableView {
    [self.view addSubview:self.contentTableView];
}

#pragma mark - property
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        CGFloat top = self.isHideNavigationBar ? 0 : NAVBARHEIGHT;
        CGRect tableRect = CGRectMake(0, top, self.view.width, self.view.height - top);
        _contentTableView = [[UITableView alloc] initWithFrame:tableRect
                                                         style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = ZLClearColor;
    }
    return _contentTableView;
}

- (void)addRefreshAction {
    weakSelf(self);
    self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        strongSelf(self);
        [self willRefresh];
    }];
    
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        strongSelf(self);
        [self willLoadMore];
    }];
}

- (void)reloadData{
    if (self.contentTableView) {
        [self.contentTableView reloadData];
    }
}

- (void)willRefresh {
    [super willRefresh];
}

- (void)doRefresh {
    [super doRefresh];
}

- (void)didRefresh {
    [super didRefresh];
    [self.contentTableView.mj_header endRefreshing];
}

- (void)willLoadMore {
    [super willLoadMore];
}

- (void)doLoadMore {
    [super doLoadMore];
}

- (void)didLoadMore {
    [super didLoadMore];
    [self.contentTableView.mj_footer endRefreshing];
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableCell *cell = [BaseTableCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}

@end
