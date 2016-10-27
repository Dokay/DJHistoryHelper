//
//  DJHistoryHandler.m
//  DJHistoryHelper
//
//  Created by Dokay on 14-7-28.
//  Copyright (c) 2014年 dj226. All rights reserved.
//

#import "DJHistoryHandler.h"

@implementation DJHistoryHandler

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static id handler;
    dispatch_once(&onceToken, ^{
        handler = [self new];
    });
    return handler;
}

#pragma --mark Test
- (id<DJHistoryDelegate>)testPlistHistory
{
    if (_testPlistHistory == nil) {
        _testPlistHistory = [[DJHistoryPlistHelper alloc]initWithName:@"testFile"];
    }
    return _testPlistHistory;
}


- (id<DJHistoryDelegate>)testDataBaseHistory
{
    if (_testDataBaseHistory == nil) {
        _testDataBaseHistory = [[DJHistoryPlistHelper alloc]initWithName:@"dataBaseHistory"];
    }
    return _testDataBaseHistory;
}

- (id<DJHistoryDelegate>)testDataBaseSimlpeHistory
{
    if (_testDataBaseSimlpeHistory == nil) {
        _testDataBaseSimlpeHistory = [[DJHistoryPlistHelper alloc] initWithName:@"dataBaseHistory"];
    }
    return _testDataBaseSimlpeHistory;
}

@end
