//
//  BaseTableViewCell.h
//  XDL
//
//  Created by LayZhang on 2017/9/11.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableCell : UITableViewCell

@property (nonatomic, strong) id cellData;

+ (NSString *)cellIdentifier;
+ (instancetype)dequeueReusableCellForTableView:(UITableView *)tableView;

- (void)cellAddSubview:(UIView*)view;

#pragma mark - 父类抽象方法 可由子类实现
- (void)reloadData;
+ (CGFloat)heightForCell:(id)cellData;
- (void)initCellComponent;


@end
