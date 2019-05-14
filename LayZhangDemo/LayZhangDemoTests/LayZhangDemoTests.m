//
//  LayZhangDemoTests.m
//  LayZhangDemoTests
//
//  Created by LayZhang on 2017/5/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface LayZhangDemoTests : XCTestCase

@end

@implementation LayZhangDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *str1 = @";;";
    NSString *str2 = @";;";
    NSInteger a= 1;
    NSInteger b = 2;
    XCTAssertEqual(str1, str2, @"111");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
