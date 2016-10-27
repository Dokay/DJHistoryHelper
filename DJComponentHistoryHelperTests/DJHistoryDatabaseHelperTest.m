//
//  DJHistoryDatabaseHelperTest.m
//  DJHistoryHelper
//
//  Created by Dokay on 14-7-29.
//  Copyright (c) 2014年 dj226. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DJHistoryHandler.h"

@interface DJHistoryDatabaseHelperTest : XCTestCase
{
    NSObject<DJHistoryDelegate> *helper;
}
@end

@implementation DJHistoryDatabaseHelperTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    helper = [DJHistoryHandler sharedInstance].testDataBaseHistory;
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
    [dicTestValue setValue:@"1111" forKey:@"num"];
    [dicTestValue setValue:@"128" forKey:@"name"];
    return dicTestValue;
}

- (void)test001_AddValue
{
    NSDictionary *dicDefauleValue = [self getDefaultData];
    XCTAssertNotNil(dicDefauleValue, @"");
    [helper insertItem:dicDefauleValue withPrimaryKey:[dicDefauleValue valueForKey:@"num"]];
}

- (void)test002_ReadValueArray
{
    NSDictionary *dicDefauleValue = [self getDefaultData];
    [helper insertItem:dicDefauleValue withPrimaryKey:[dicDefauleValue valueForKey:@"num"]];
    
    NSArray *arrTest = [helper readFromLoacl];
    XCTAssertNotNil(arrTest, @"");
    XCTAssertTrue(arrTest.count > 0, @"");
    
    NSDictionary *dicValue = arrTest[0];
    XCTAssertNotNil(dicValue, @"");
    XCTAssertTrue([[dicValue valueForKey:@"num"] isEqualToString:@"1111"], @"");
}

- (void)test003_ReadValueObject
{
    NSDictionary *dicDefauleValue = [self getDefaultData];
    [helper insertItem:dicDefauleValue withPrimaryKey:[dicDefauleValue valueForKey:@"num"]];
    
    NSDictionary *dicValue = (NSDictionary *)[helper readFromLocalWithObject:@"126"];
    XCTAssertNil(dicValue, @"");
    
    dicValue = (NSDictionary *)[helper readFromLocalWithObject:@"1111"];
    XCTAssertNotNil(dicValue, @"");
    XCTAssertTrue([[dicValue valueForKey:@"num"] isEqualToString:@"1111"], @"");
    
}

- (void)test004_ClearAll
{
    [helper removeAllItem];
    
    NSArray *arrTest = [helper readFromLoacl];
    XCTAssertNotNil(arrTest, @"");
    XCTAssertTrue(arrTest.count == 0, @"");
    
}


@end
