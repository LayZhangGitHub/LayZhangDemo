//
//  ZLTabbar.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLTabbarDelegate;

@interface ZLTabbar : UIView

@property (nonatomic, weak) id<ZLTabbarDelegate> delegate;
@property (nonatomic, assign) NSUInteger selectedIndex;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<ZLTabbarDelegate>)delegate;
- (void)setBackgroundImage:(UIImage *)backgroundImage;

@end

@protocol ZLTabbarDelegate <NSObject>

@optional
- (void)tabBar:(ZLTabbar *)zlTabbar didSelectItemAtIndex:(NSInteger)index;
- (BOOL)tabBar:(ZLTabbar *)zlTabbar couldSelectItemAtindex:(NSInteger)index;

@end
