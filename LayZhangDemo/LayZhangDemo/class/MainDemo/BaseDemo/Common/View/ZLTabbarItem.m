//
//  ZLTabbarItem.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLTabbarItem.h"

@interface ZLTabbarItem ()

@property (nonatomic, strong) UIImageView    *imageView;
@property (nonatomic, strong) UILabel        *titleLabel;

@property (nonatomic, strong) UIView         *backgroundView;

@property (nonatomic, strong) UIImage        *icon;
@property (nonatomic, strong) UIImage        *selectedIcon;
@property (nonatomic, strong) UIColor        *titleColor;
@property (nonatomic, strong) UIColor        *selectedTitleColor;

@property (nonatomic, strong) NSString          *title;
@property (nonatomic, assign) CGFloat           imageWH;


@end

@implementation ZLTabbarItem

- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
           selectedTitleColor:(UIColor *)selectedTitleColor
                         icon:(UIImage *)icon
                 selectedIcon:(UIImage *)selectedIcon {
    if (self = [super init]) {
        
        self.selected = NO;
        self.icon = icon;
        self.selectedIcon = selectedIcon;
        self.titleColor = titleColor;
        self.selectedTitleColor = selectedTitleColor;
        self.title = title;
        
        _imageWH = 40.f;
        if (!IsEmptyString(title)) {
            _imageWH = 30.f;
        }
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.imageView];
        
        [self addTarget:self action:@selector(didSelect) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - property
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = ZLClearColor;
        _titleLabel.textColor = self.titleColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.userInteractionEnabled = NO;
        _titleLabel.text = self.title;
        _titleLabel.font = ZLNormalFont(10);
    }
    return _titleLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = self.icon;
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = CGRectMake(0, 5, _imageWH, _imageWH);
    _imageView.centerX = self.width / 2;
    
    _titleLabel.frame = CGRectMake(0, _imageView.bottom, self.width, 20);
}

#pragma mark - action
- (void)didSelect {
    if ([self.delegate respondsToSelector:@selector(tabBarItemdidSelected:)]) {
        [self.delegate tabBarItemdidSelected:self];
    }
}

#pragma mark - override
- (void)setSelected:(BOOL)selected {
    if (self.selected == selected) {
        return;
    }
    [super setSelected:selected];
    
    if (!selected) {
        self.imageView.image = self.icon;
        self.titleLabel.textColor = self.titleColor;
    } else {
        self.imageView.image = self.selectedIcon;
        self.titleLabel.textColor = self.selectedTitleColor;
    }
}



@end
