//
//  AnnoucementCell.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/24.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "AnnoucementCell.h"
#import "MessageModel.h"

@interface AnnoucementCell ()

@property (nonatomic, weak) UILabel *content1Label;
@property (nonatomic, weak) UILabel *content2Label;
@property (nonatomic, weak) UILabel *content3Label;

@end

@implementation AnnoucementCell

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"AnnoucementCell";
    AnnoucementCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[AnnoucementCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        /** background **/
        self.backgroundColor = ZLColor(243, 245, 249);
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:ZLColor(243, 245, 249)]];
        
        /** content1 **/
        UILabel *content1Label = [UILabel labelWithText:@""
                                              textColor:[UIColor blackColor]
                                                   font:28 * SCALE
                                            textAliment:NSTextAlignmentLeft];
        self.content1Label = content1Label;
        content1Label.numberOfLines = 0;
        [self.contentView addSubview:content1Label];
        [content1Label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20 * SCALE);
            make.right.equalTo(self.contentView.mas_right).offset(- 20 * SCALE);
            make.top.equalTo(self.contentView.mas_top).offset(20 * SCALE);
        }];
        
        /** content2 **/
        UILabel *content2Label = [UILabel labelWithText:@""
                                              textColor:[UIColor blackColor]
                                                   font:28 * SCALE
                                            textAliment:NSTextAlignmentLeft];
        self.content2Label = content2Label;
        content2Label.numberOfLines = 0;
        [self.contentView addSubview:content2Label];
        [content2Label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20 * SCALE);
            make.right.equalTo(self.contentView.mas_right).offset(- 20 * SCALE);
            make.top.equalTo(self.content1Label.mas_bottom).offset(20 * SCALE);
        }];
        
        /** content3Label **/
        UILabel *content3Label = [UILabel labelWithText:@""
                                              textColor:[UIColor blackColor]
                                                   font:28 * SCALE
                                            textAliment:NSTextAlignmentLeft];
        self.content3Label = content3Label;
        content3Label.numberOfLines = 0;
        [self.contentView addSubview:content3Label];
        [content3Label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20 * SCALE);
            make.right.equalTo(self.contentView.mas_right).offset(- 20 * SCALE);
            make.top.equalTo(self.content2Label.mas_bottom).offset(20 * SCALE);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-20 * SCALE);
        }];
    }
    
    return self;
}

- (void)setMessage:(MessageModel *)message {
    
    _message = message;
    
    self.content1Label.text = message.content1;
    self.content2Label.text = message.content2;
    self.content3Label.text = message.content3;
    
}

@end
