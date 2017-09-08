//
//  CustomViewController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "CustomAlertController.h"
#import "ZLCVerifyCodeAlertView.h"
#import "ZLMVerifyCodeAlertView.h"

@interface CustomAlertController ()<UITableViewDelegate, UITableViewDataSource, ZLVerifyDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;
@end

@implementation CustomAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [ZLCVerifyCodeAlertView show];

    [self createNavBarWithTitle:@"VerifyCodeDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
    [self initTableView];
}

- (NSArray *)items {
    if (_items == nil) {
        _items = @[@"ZLCVerifyCodeAlertView", @"ZLMVerifyCodeAlertView"];
    }
    return _items;
}

- (void)initTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = ZLRGB(240, 240, 240);
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    [backView addSubview:tableView];
    
    [self.view addSubview:backView];
}

#pragma mark - tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"CustomAlertViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:[UIColor whiteColor]]];
        
        cell.textLabel.textColor = ZLRGB(39, 39, 39);
        cell.textLabel.font = [UIFont systemFontOfSize:28 * SCALE];
    }
    cell.textLabel.text = self.items[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self showZLCVerifyCodeAlertView];
            break;
        case 1:
            [self showZLMVerifyCodeAlertView];
            break;
        default:
            break;
    }
}

#pragma mark - show alert
- (void)showZLCVerifyCodeAlertView {
    [[NSClassFromString(@"ZLCVerifyCodeAlertView") sharedSendVerifyCodeView] setDelegate:self];
    [NSClassFromString(@"ZLCVerifyCodeAlertView") show];
}

- (void)didSelectAlert:(UIView *)alertView isOK:(Boolean)isOK {
//    [NSClassFromString(@"ZLCVerifyCodeAlertView") dismiss];
    if ([alertView isKindOfClass:[ZLCVerifyCodeAlertView class]]) {
         [ZLCVerifyCodeAlertView dismiss];
    }
    if ([alertView isKindOfClass:[ZLMVerifyCodeAlertView class]]) {
        [ZLMVerifyCodeAlertView dismiss];
    }
}

- (void)showZLMVerifyCodeAlertView {
    [[NSClassFromString(@"ZLMVerifyCodeAlertView") sharedSendVerifyCodeView] setDelegate:self];
    [NSClassFromString(@"ZLMVerifyCodeAlertView") show];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
