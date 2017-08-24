//
//  BaseCell.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/22.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UICollectionViewCell

/**
 *  cell 的数据对象
 */
@property (nonatomic, strong) id cellData;

/**
 *  reloadData 方法，子类自己实现
 */
- (void)reloadData;

- (void)cellAddSubview:(UIView *)view;

/**
 *  返回当前 cell 的 identifier，默认为类名
 *
 *  @return 当前 cell 的 identifier
 */
+ (NSString *)cellIdentifier;

/**
 *  获得cell高度
 */
+ (CGFloat)heightForCell:(id)cellData;

@end
