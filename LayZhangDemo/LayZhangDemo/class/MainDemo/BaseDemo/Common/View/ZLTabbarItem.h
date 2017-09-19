//
//  ZLTabbarItem.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLTabbarItemDelegate;

@interface ZLTabbarItem : UIControl

@property (nonatomic, weak) id<ZLTabbarItemDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor icon:(UIImage *)icon selectedIcon:(UIImage *)selectedIcon;


@end


@protocol ZLTabbarItemDelegate <NSObject>

@optional
- (void)tabBarItemdidSelected:(ZLTabbarItem *)item;

@end
