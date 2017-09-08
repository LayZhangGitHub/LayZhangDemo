//
//  ZLAlertView.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLAlertViewDelegate;

@interface ZLAlertView : UIView
@property (nonatomic, strong) UIWindow  *window;
@property (nonatomic, strong) UIView    *overlayView;
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UILabel   *messageLabel;
@property (nonatomic, strong) UIView    *containerView;
@property (nonatomic, weak) id<ZLAlertViewDelegate> delegate;


- (id)initWithTitle:(NSString *)title message:(NSString *)message containerView:(UIView *)containerView delegate:(id <ZLAlertViewDelegate>)delegate confirmButtonTitle:(NSString *)confirmButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;

- (void)show;

@end

@protocol ZLAlertViewDelegate <NSObject>


@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(ZLAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

- (void)alertView:(ZLAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)alertView:(ZLAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation

@end
