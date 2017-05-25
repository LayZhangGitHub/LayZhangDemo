//
//  AnnoucementCell.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/24.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageModel;

@interface AnnoucementCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) MessageModel *message;

@end
