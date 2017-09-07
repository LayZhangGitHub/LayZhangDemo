//
//  SafeKitController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/24.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "SafeKitController.h"
//#import "SafeObjectMarco.h"
//#import "NSArray+Safe.h"


@interface SafeKitController ()

@end

@implementation SafeKitController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self safeTest];
    
//    UITextField *textField = [[UITextField alloc] init];
//    textField.backgroundColor = [UIColor redColor];
//    textField.frame = CGRectMake(10, 100, 300, 40);
//    [self.view addSubview:textField];
}

- (void)safeTest {
    NSString *nilString = nil;
//    NSArray *array = @[];
//    NSString *value = array[2];
//    NSLog(@"%@", value);

    
    
//    NSArray *array1 = [[NSArray alloc] initWithObjects:@"123", nilString, @"1", nil];
//    NSString *value1 = array1[3];
//    NSLog(@"%@", value1);
//
//    NSArray *array2 = @[];
//    NSString *value2 = array2[0];
//    NSLog(@"%@", value2);
    
//    NSMutableArray *array3 = [[NSMutableArray alloc] init];
//    NSString *value3 = array3[0];
//    [array3 setObject:nilString atIndexedSubscript:0];
//    [array3 addObject:nilString];
//    [array3 removeObjectAtIndex:3];
//    [array3 insertObject:@"123" atIndex:9];
//    NSLog(@"%@", value3);
//
//    [array3 insertObject:nilString atIndex:100];
    
//    NSDictionary *dic = @{
//                          };
//    
//    id obect =  [dic objectForKey:nilString];
//    NSLog(@"%@", obect);
    
//    array3 insertObject:<#(nonnull id)#> atIndex:<#(NSUInteger)#>
//    array3 setObject:<#(nonnull id)#> atIndexedSubscript:<#(NSUInteger)#>

    
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:nil forKey:@"key"];
//    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
//    [mDic setObject:nilString forKey:@"key"];
//    [mDic removeObjectForKey:nilString];
//    NSLog(@"%@", mDic);
    
//    NSString *emptyString = nil;
//
    
    NSMutableSet *set = [NSMutableSet setWithObjects:@"123", nil];
    NSLog(@"%@", set);
    for (id obj in set) {
        NSLog(@"object %@", obj);
    }
    [set addObject:nilString];
    [set addObject:@"123"];
    [set removeObject:@"12"];
    [set removeObject:nilString];
}



@end
