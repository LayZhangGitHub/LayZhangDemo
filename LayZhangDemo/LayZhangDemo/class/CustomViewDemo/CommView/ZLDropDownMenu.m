//
//  ZLDropDownMenu.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/9/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLDropDownMenu.h"


#define AnimateTime 0.3f
#define DropDownHeight 300

@interface ZLDropDownMenu()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIButton *mainButton;
@property (nonatomic, weak) UIImageView *arrowImageView;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, weak) UIView *tableBackgroundView;
@property (nonatomic, weak) UITableView *contentTableView;

@end

@implementation ZLDropDownMenu

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initComponent];
    }
    return self;
}

- (void)initComponent {
    
    self.layer.borderColor  = [UIColor blackColor].CGColor;
    self.layer.borderWidth  = LINEWIDTH;
    
    UIButton *mainButton = [[UIButton alloc] init];
    [mainButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [mainButton setTitle:@"请选择" forState:UIControlStateNormal];
    [mainButton addTarget:self action:@selector(clickMainButton:) forControlEvents:UIControlEventTouchUpInside];
    mainButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    mainButton.titleLabel.font    = [UIFont systemFontOfSize:14.f];
    mainButton.selected           = NO;
    mainButton.backgroundColor    = [UIColor whiteColor];
//    mainButton.layer.borderColor  = [UIColor blackColor].CGColor;
//    mainButton.layer.borderWidth  = LINEWIDTH;
    self.mainButton = mainButton;
    [self addSubview:mainButton];

    UIImageView *arrowImageView = [[UIImageView alloc] init];
    [arrowImageView setImage:[UIImage imageNamed:@"icon_back"]];
    self.arrowImageView = arrowImageView;
    [self addSubview:arrowImageView];
}

- (void)setMenuTitles:(NSArray *)dataArray rowHeight:(CGFloat)rowHeight {
    _dataArray = dataArray;
    _rowHeight = rowHeight;
}

- (void)addDropDownView {
    // 下拉列表背景View
    UIView *tableBackgroundView = [[UIView alloc] init];
    tableBackgroundView.frame = CGRectMake(self.left , self.bottom, self.width,  0);
    tableBackgroundView.clipsToBounds       = YES;
    tableBackgroundView.layer.masksToBounds = NO;
    tableBackgroundView.layer.borderColor   = [UIColor lightTextColor].CGColor;
    tableBackgroundView.layer.borderWidth   = LINEWIDTH;
    self.tableBackgroundView = tableBackgroundView;
    [self.superview addSubview:tableBackgroundView];
    
    // 下拉列表TableView
    UITableView *contentTableView = [[UITableView alloc] init];
    contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, tableBackgroundView.width, tableBackgroundView.height)];
    contentTableView.delegate        = self;
    contentTableView.dataSource      = self;
    contentTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    contentTableView.bounces         = NO;
    self.contentTableView = contentTableView;
    [tableBackgroundView addSubview:contentTableView];
}


- (void)clickMainButton:(UIButton *)mainButton {
    
    if(mainButton.selected == NO) {
        [self showDropDown];
    }
    else {
        [self hideDropDown];
    }
}

- (void)showDropDown {
    if (!_tableBackgroundView) {
        [self addDropDownView];
    }
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillAppear:)]) {
        [self.delegate dropdownMenuWillAppear:self];
    }
    
    [UIView animateWithDuration:AnimateTime animations:^{
        _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        CGFloat viewHeight = DropDownHeight > _dataArray.count * _rowHeight ? _dataArray.count * _rowHeight : DropDownHeight;
        _tableBackgroundView.frame  = CGRectMake(self.left, self.bottom, self.width, viewHeight);
        _contentTableView.frame = CGRectMake(0, 0, _tableBackgroundView.width, _tableBackgroundView.height);
    }completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(dropdownMenuDidAppear:)]) {
            [self.delegate dropdownMenuDidAppear:self];
        }
        _mainButton.selected = YES;
        LogGRect(_tableBackgroundView.frame);
    }];
}

- (void)hideDropDown {
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillDisappear:)]) {
        [self.delegate dropdownMenuWillDisappear:self];
    }
    
    [UIView animateWithDuration:AnimateTime animations:^{
        
        _arrowImageView.transform = CGAffineTransformIdentity;
        _tableBackgroundView.frame  = CGRectMake(_tableBackgroundView.left, self.bottom, self.width, 0);
        _contentTableView.frame = CGRectMake(0, 0, _tableBackgroundView.width, _tableBackgroundView.height);
        
    }completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDisappear:)]) {
            [self.delegate dropdownMenuDidDisappear:self];
        }
        _mainButton.selected = NO;
        LogGRect(_tableBackgroundView.frame);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect mainButtonRect = CGRectMake(15 * SCALE, 0, self.width - 35 * SCALE, self.height);
    _mainButton.frame = mainButtonRect;
    
    _arrowImageView.frame = CGRectMake(0, 0, 20 * SCALE, 20 * SCALE);
    _arrowImageView.center = CGPointMake(0, self.height / 2);
    _arrowImageView.left = _mainButton.right;
}

#pragma mark - UITableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font          = [UIFont systemFontOfSize:11.f];
        cell.textLabel.textColor     = [UIColor blackColor];
        cell.selectionStyle          = UITableViewCellSelectionStyleNone;
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, _rowHeight -0.5, cell.width, 0.5)];
        line.backgroundColor = [UIColor blackColor];
        [cell addSubview:line];
    }
    
    cell.textLabel.text =[_dataArray objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [_mainButton setTitle:cell.textLabel.text forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenu:selectedCellIndex:)]) {
        [self.delegate dropdownMenu:self selectedCellIndex:indexPath.row];
    }
    
    [self hideDropDown];
}

@end
