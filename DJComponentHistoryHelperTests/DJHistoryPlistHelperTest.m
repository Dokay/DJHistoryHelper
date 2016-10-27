//
//  DJHistoryPlistHelperTest.m
//  DJHistoryHelper
//
//  Created by Dokay on 14-7-29.
//  Copyright (c) 2014年 dj226. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DJHistoryPlistHelper.h"
#import "DJHistoryHandler.h"

@interface DJHistoryPlistHelperTest : XCTestCase
{
    NSObject<DJHistoryDelegate> *helper;
}
@end

@implementation DJHistoryPlistHelperTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
//    helper = [[DJHistoryPlistHelper alloc]initWithFileName:@"TestDJHistoryPlistHelper"];
    helper = [DJHistoryHandler sharedInstance].testPlistHistory;
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}

- (NSDictionary *)getDefaultData
{
    NSMutableDictionary *dicTestValue = [NSMutableDictionary new];
    [dicTestValue setValue:@"1111" forKey:@"testKey"];
    [dicTestValue setValue:@"128" forKey:@"ppp"];
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
    
    NSDictionary *dicValue = arrTest[0];
    XCTAssertNotNil(dicValue, @"");
    XCTAssertTrue([[dicValue valueForKey:@"testKey"] isEqualToString:@"1111"], @"");
}

- (void)test003_ReadValueObject
{
    NSDictionary *dicDefauleValue = [self getDefaultData];
    [helper insertItem:dicDefauleValue withPrimaryKey:[dicDefauleValue valueForKey:@"ppp"]];
    
    NSDictionary *dicValue = (NSDictionary *)[helper readFromLocalWithObject:@"126"];
    XCTAssertNil(dicValue, @"");
    
    dicValue = (NSDictionary *)[helper readFromLocalWithObject:@"128"];
    XCTAssertNotNil(dicValue, @"");
    XCTAssertTrue([[dicValue valueForKey:@"testKey"] isEqualToString:@"1111"], @"");

}

- (void)test004_ClearAll
{
    [helper removeAllItem];

    NSArray *arrTest = [helper readFromLoacl];
    XCTAssertNotNil(arrTest, @"");
    XCTAssertTrue(arrTest.count == 0, @"");

}

@end
