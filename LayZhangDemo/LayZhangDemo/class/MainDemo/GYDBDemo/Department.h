//
//  Department.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/11/28.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "GYDataCenter.h"

@interface Department : GYModelObject


@property (nonatomic, readonly, assign) NSInteger departmentId;

@property (nonatomic, readonly, assign) int intProperty;
@property (nonatomic, readonly, assign) unsigned unsignedProperty;
@property (nonatomic, readonly, assign) short shortProperty;
@property (nonatomic, readonly, assign) long longProperty;
@property (nonatomic, readonly, assign) unsigned long unsignedLongProperty;
@property (nonatomic, readonly, assign) long long longLongProperty;
@property (nonatomic, readonly, assign) unsigned long long unsignedLongLongProperty;
@property (nonatomic, readonly, assign) bool booleanProperty;
@property (nonatomic, readonly, assign) float floatProperty;
@property (nonatomic, readonly, assign) double doubleProperty;
@property (nonatomic, readonly, assign) char charProperty;
@property (nonatomic, readonly, assign) BOOL BOOLProperty;
@property (nonatomic, readonly, strong) NSString *stringProperty;
@property (nonatomic, readonly, strong) NSMutableString *mutableStringProperty;
@property (nonatomic, readonly, strong) NSDate *dateProperty;
@property (nonatomic, readonly, strong) NSData *dataProperty;
@property (nonatomic, readonly, strong) NSArray *arrayProperty;

@end
