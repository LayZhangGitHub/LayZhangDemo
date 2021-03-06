//
//  JSONModel01.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/23.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "JSONModel02.h"
@interface JSONModel01 : JSONModel

@property (nonatomic, assign) int intValue;
@property (nonatomic, strong) NSString *stringValue;
@property (nonatomic, assign) BOOL boolValue;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) JSONModel02 *mModel;

@end
