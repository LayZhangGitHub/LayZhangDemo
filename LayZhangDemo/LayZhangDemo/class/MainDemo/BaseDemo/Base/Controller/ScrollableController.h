//
//  ScrollableController.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseController.h"

@interface ScrollableController : BaseController

@property (nonatomic, assign) BOOL      isBackToTop;
@property (nonatomic, strong) UIButton  *backToTopButton;
@property (nonatomic, assign) CGFloat   lastPosition;

- (void)willRefresh;
- (void)doRefresh;
- (void)didRefresh;

- (void)willLoadMore;
- (void)doLoadMore;
- (void)didLoadMore;

- (void)loadData;

@end
