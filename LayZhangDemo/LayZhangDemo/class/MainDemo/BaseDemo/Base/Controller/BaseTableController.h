//
//  BaseTableController.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ScrollableController.h"

@interface BaseTableController : ScrollableController

@property (nonatomic, strong) UITableView *tableView;

- (void)addTableView;
- (void)showNoMoreDataNotice:(NSString *)text;
- (void)hideNoMoreDataNotice;
- (void)reloadData;

@end
