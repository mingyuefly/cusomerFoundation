//
//  unitTestTests.m
//  unitTestTests
//
//  Created by mingyue on 16/5/30.
//  Copyright © 2016年 G. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface unitTestTests : XCTestCase

@property (nonatomic, strong)ViewController *viewC;

@end

@implementation unitTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.viewC = [[ViewController alloc]init];//测试前执行，初始化控制器
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.viewC = nil;//测试后执行，释放控制器
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    int result = [self.viewC getMaxNumber:100];
    XCTAssertEqual(result, 200, @"测试不通过");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 5; j++) {
                NSLog(@"jj");
            }
            NSLog(@"ii");
        }
    }];
}

@end
