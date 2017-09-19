//
//  ZLTabbar.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLTabbar.h"
#import "ZLTabbarItem.h"

@interface ZLTabbar()<ZLTabbarItemDelegate>

@property(nonatomic, retain) NSMutableArray *items;
@property(nonatomic, retain) UIVisualEffectView *effectView;
@property(nonatomic, retain) UIView *barPanel;
@property(nonatomic, retain) UIView *topBorderLineView;

@end

@implementation ZLTabbar

- (id)initWithFrame:(CGRect)frame
              items:(NSArray *)items
           delegate:(id<ZLTabbarDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {
        self.delegate = delegate;
        self.items = [items copy];
        [self initContent];
    }
    return self;
}

#pragma mark - property

- (void)layoutSubviews {
    [super layoutSubviews];
    _effectView.frame = self.bounds;
    _topBorderLineView.frame = CGRectMake(0, 0, SCREENWIDTH, LINEWIDTH);
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _effectView.tintColor = ZLThemeCtrInstance.tabBarBackgroundColor;
    }
    return _effectView;
}

- (UIView *)topBorderLineView {
    if (!_topBorderLineView) {
        _topBorderLineView = [[UIView alloc] init];
        _topBorderLineView.backgroundColor = ZLThemeCtrInstance.tabBarTopBorderColor;
    }
    return _topBorderLineView;
}

- (void)initContent {
    [self addSubview:self.effectView];
    self.barPanel = self.effectView.contentView;
    
    [self addSubview:self.topBorderLineView];
    [self bringSubviewToFront:self.topBorderLineView];
    
    self.selectedIndex = 0;
    [self initItems];
}


- (void)initItems {
    NSUInteger barNum = self.items.count;
    CGFloat width = (self.width) / barNum;
    
    for (int i = 0; i < barNum; i++) {
        ZLTabbarItem *item = self.items[i];
        item.width = width;
        item.height = self.height;
        item.left = width * i;
        item.delegate = self;
        if (i == self.selectedIndex) {
            item.selected = YES;
        }
//        item.tag = i;
        [self.barPanel addSubview:item];
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    self.barPanel.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
}

- (void)selectItemAtIndex:(NSInteger)index {
    if (index < self.items.count) {
        [self tabBarItemdidSelected:self.items[index]];
    }
}

#pragma -mark tabbar item delegate
- (void)tabBarItemdidSelected:(ZLTabbarItem *)item{
    
    NSUInteger index = [self.items indexOfObject:item];
    
    if (index >= [self.items count]) {
        return;
    }
    
    if (self.selectedIndex != index) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:couldSelectItemAtindex:)]) {
            if(![self.delegate tabBar:self couldSelectItemAtindex:index]) { return; }
        }
        
        ZLTabbarItem *old = [self.items objectAtIndex:self.selectedIndex];
        if (old) {
            old.selected = NO;
        }
    }
    
    self.selectedIndex = index;
    item.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]) {
        [self.delegate tabBar:self didSelectItemAtIndex:index];
    }
}

// 实现类似咸鱼 凸出 按钮 响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        UIView *view = [super hitTest:point withEvent:event];
        if (view) { return view; }else {
            for (UIView *subView in self.subviews.reverseObjectEnumerator) {
                CGPoint subPoint = [self convertPoint:point toView:subView];
                view = [subView hitTest:subPoint withEvent:event];
                if (view) {
                    return view;
                }
            }
        }
    }
    return nil;
}

@end
