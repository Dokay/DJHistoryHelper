//
//  DJHistoryHandler.h
//  DJHistoryHelper
//
//  Created by Dokay on 14-7-28.
//  Copyright (c) 2014年 dj226. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJHistoryPlistHelper.h"

@interface DJHistoryHandler : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) id<DJHistoryDelegate> testPlistHistory;


@property (nonatomic, strong) id<DJHistoryDelegate> testDataBaseHistory;

@property (nonatomic, strong) id<DJHistoryDelegate> testDataBaseSimlpeHistory;

@end
