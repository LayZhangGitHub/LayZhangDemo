//
//  PropertyDemoController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/26.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "PropertyDemoController.h"

@interface PropertyDemoController () {
    NSString *_name;
}

@property (nonatomic, copy) NSString *name;

@end

@implementation PropertyDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"propertyDemo" withLeft:[UIImage imageNamed:@"icon_back"]];
}

- (void)propertyDemo {
//    self.name = @"";
//     self.name
//    _name
}

- (NSString *)name {
    return _name;
}

- (void)setName:(NSString *)name {
    if (_name != name) {
//        [_name release];
        _name = [name copy];
    }
}
@end
