//
//  YJSONModel01.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/25.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJSONModel02.h"

@interface YJSONModel01 : NSObject

@property (nonatomic, assign) int intValue;
@property (nonatomic, strong) NSString *stringValue;
@property (nonatomic, assign) BOOL boolValue;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray<YJSONModel02*> *mModel;

@end
