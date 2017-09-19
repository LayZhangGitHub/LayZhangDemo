//
//  BaseController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ZLFuncLineLog();
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    ZLFuncLineLog();
//    DBG(@"viewWillDisappear %@", NSStringFromClass(self.class));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZLThemeCtrInstance.backgroundColor;
    [self.navigationController.navigationBar setHidden:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.needBlurEffect = YES;
}

#pragma mark - override uiviewcontroller settitle
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    if (_navigationBar) {
        [_navigationBar setTitle:title];
    }
}

- (void)showNavigationBar {
    
    if (self.isHideNavigationBar) {
        ZLWarningLog(@"navigation is hide, can not show!");
        return;
    }
    
    if (!_navigationBar) {
        _navigationBar = [[ZLNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, NAVBARHEIGHT) needBlurEffect:self.needBlurEffect];
        _navigationBar.backgroundColor = ZLThemeCtrInstance.navigationButtonColor;
        _navigationBar.tintColor = ZLThemeCtrInstance.navigationButtonColor;
        _navigationBar.title = self.title;
        
        if (self.navigationController && self.navigationController.viewControllers.count > 1) {
            UIButton *backButton = [UIButton buttonWithTarget:self
                                                       action:@selector(navigationBackAction)
                                             forControlEvents:UIControlEventTouchUpInside];
            backButton.size = CGSizeMake(40, 40);
            [_navigationBar setLeftButton:backButton];
        }
        [_navigationBar setBottomBorderColor:ZLThemeCtrInstance.navigationBottomBorderColor];
        
        [self.view addSubview:_navigationBar];
    }
    _navigationBar.hidden = NO;
}

- (void)hideNavigationBar {
    if (_navigationBar) {
        _navigationBar.hidden = YES;
    }
}

- (void)navigationBackAction {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
