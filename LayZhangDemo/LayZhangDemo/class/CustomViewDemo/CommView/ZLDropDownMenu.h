//
//  ZLDropDownMenu.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLDropdownMenuDelegate;

@interface ZLDropDownMenu : UIView

@property (nonatomic, assign) id <ZLDropdownMenuDelegate>delegate;

- (void)setMenuTitles:(NSArray *)dataArray
            rowHeight:(CGFloat)rowHeight;

- (void)showDropDown;
- (void)hideDropDown;

@end

@protocol ZLDropdownMenuDelegate <NSObject>

@optional

- (void)dropdownMenuWillAppear:(ZLDropDownMenu *)menu;
- (void)dropdownMenuDidAppear:(ZLDropDownMenu *)menu;
- (void)dropdownMenuWillDisappear:(ZLDropDownMenu *)menu;
- (void)dropdownMenuDidDisappear:(ZLDropDownMenu *)menu;

/**
 点击显示 选中index
 @param menu menuView
 @param index selectIndex
 */
- (void)dropdownMenu:(ZLDropDownMenu *)menu
   selectedCellIndex:(NSInteger)index;

@end
