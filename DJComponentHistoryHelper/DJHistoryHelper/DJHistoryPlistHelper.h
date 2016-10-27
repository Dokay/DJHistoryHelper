//
//  DJHistoryPlistHelper.h
//  DJHistoryHelper
//
//  Created by Dokay on 14-7-28.
//  Copyright (c) 2014年 dj226. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJHistoryBase.h"

@interface DJHistoryPlistHelper : NSObject<DJHistoryDelegate>

/**
 *  文件存储路径，子类可overwrite
 *
 *  @return
 */
- (NSString *)getFilePath;

@end
