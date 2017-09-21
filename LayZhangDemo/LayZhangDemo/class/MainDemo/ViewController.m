//
//  ViewController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ViewController.h"
#import "UIView+ZLEX.h"
#import "ZLPreMacro.h"
#import "MainViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *groups;

@property (nonatomic, copy) NSMutableArray *mArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"mainView"];
    [self initTableView];
    
    NSURL *url = [NSURL URLWithString:@"http://baidu.com?test=1111"];
    NSLog(@"%@", url.scheme);
    NSLog(@"%@", url.host);
    NSLog(@"%@", url.absoluteString);
    
    
//    NSMutableString *string = [NSMutableString stringWithString: @"origion"];
//    NSString *stringCopy = [string copy];
//    NSMutableString *mStringCopy = [string copy];
//    NSMutableString *stringMCopy = [string mutableCopy];
//    [mStringCopy appendString:@"mm"];//error
//    [string appendString:@" origion!"];
//    [stringMCopy appendString:@"!!"];
//    NSMutableArray *mArray = [[NSMutableArray alloc] init];
//    self.mArray = mArray;
//    NSLog(@"%@", [self.mArray class]);
}

- (NSArray *)groups {
    if (_groups == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ZLDemoList" ofType:@"plist"];
        _groups = [NSArray arrayWithContentsOfFile:path];
        NSLog(@"%@", _groups);
    }
    return _groups;
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
    MainViewCell *cell = [MainViewCell cellWithTableView:tableView];
    cell.item = self.groups[indexPath.section][indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.groups[section] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    XMLParseController *con = [[XMLParseController alloc] init];
    NSString *controllerName = self.groups[indexPath.section][indexPath.row][@"controllerName"];
    [self.navigationController pushViewController:[[NSClassFromString(controllerName) alloc] init]
                                         animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
