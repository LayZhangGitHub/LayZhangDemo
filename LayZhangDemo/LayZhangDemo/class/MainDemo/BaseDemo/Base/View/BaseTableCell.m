//
//  BaseTableViewCell.m
//  XDL
//
//  Created by LayZhang on 2017/9/11.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseTableCell.h"

@implementation BaseTableCell

// 类名一般来说都是 第一无二的, 使用类名 作 identifier
+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)dequeueReusableCellForTableView:(UITableView *)tableView {
    id cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier]];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault
                           reuseIdentifier:[self cellIdentifier]];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        [self initCellComponent];
    }
    return self;
}

- (void)initCellComponent {
    
}

- (void)setCellData:(id)cellData {
    _cellData = cellData;
    if (cellData) {
        [self reloadData];
    }
}

- (void)cellAddSubview:(UIView*)view {
    [self.contentView addSubview:view];
}

- (void)reloadData {
    
}

+ (CGFloat)heightForCell:(id)cellData {
    return 0;
}

@end
