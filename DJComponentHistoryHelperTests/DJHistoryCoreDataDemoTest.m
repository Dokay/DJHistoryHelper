//
//  DJHistoryExpressReceivedTest.m
//  DJHistoryHelper
//
//  Created by Dokay on 14-7-29.
//  Copyright (c) 2014年 dj226. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DJHistoryCoreDataDemoHelper.h"
#import "DJHistoryHandler.h"

@interface DJHistoryCoreDataDemoTest : XCTestCase
{
    NSObject<DJHistoryDelegate> *helper;
}
@end

@implementation DJHistoryCoreDataDemoTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    helper = [[DJHistoryCoreDataDemoHelper alloc] initWithName:@"TestCoreDataModel"];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample
//{
//    STFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}
- (NSDictionary *)getDefaultData
{
    NSMutableDictionary *dicTestValue = [NSMutableDictionary new];
    [dicTestValue setValue:@"128" forKey:@"code"];
    [dicTestValue setValue:@"dokay" forKey:@"name"];
    return dicTestValue;
}

- (void)test001_AddValue
{
    NSDictionary *dicDefauleValue = [self getDefaultData];
    XCTAssertNotNil(dicDefauleValue, @"");
    [helper insertItem:dicDefauleValue withPrimaryKey:[dicDefauleValue valueForKey:@"ppp"]];
}

- (void)test002_ReadValueArray
{
    NSDictionary *dicDefauleValue = [self getDefaultData];
    [helper insertItem:dicDefauleValue withPrimaryKey:[dicDefauleValue valueForKey:@"ppp"]];
    
    NSArray *arrTest = [helper readFromLoacl];
    XCTAssertNotNil(arrTest, @"");
    XCTAssertTrue(arrTest.count > 0, @"");
    
    TestCoreDataModel *express = arrTest[0];
    XCTAssertNotNil(express, @"");
    XCTAssertTrue([express.name isEqualToString:@"dokay"], @"");
}

- (void)test003_ReadValueObject
{
    TestCoreDataModel *dicValue = (TestCoreDataModel *)[helper readFromLocalWithObject:@"126"];
    XCTAssertNil(dicValue, @"");
    
    dicValue = (TestCoreDataModel *)[helper readFromLocalWithObject:@"128"];
    XCTAssertNotNil(dicValue, @"");
    XCTAssertTrue([dicValue.name isEqualToString:@"dokay"], @"");
    
}

- (void)test004_ClearAll
{
    [helper removeAllItem];
    
    NSArray *arrTest = [helper readFromLoacl];
    XCTAssertNotNil(arrTest, @"");
    XCTAssertTrue(arrTest.count == 0, @"");
    
}

@end
