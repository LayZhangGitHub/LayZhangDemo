//
//  TableTimerTableViewCell.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/17.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableTimerTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *item;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
