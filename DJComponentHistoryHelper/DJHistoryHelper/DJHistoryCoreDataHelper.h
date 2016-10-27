//
//  DJHistoryCoreDataHelper.h
//  DJHistoryHelper
//
//  Created by Dokay on 14-7-28.
//  Copyright (c) 2014年 dj226. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJHistoryBase.h"
#import <CoreData/CoreData.h>

@interface DJHistoryCoreDataHelper : NSObject<DJHistoryDelegate>

/**
 *  填充数据库对象，子类实现
 *
 *  @param context 待填充的数据库对象
 *  @param object  填充的参数
 */
- (void)updateDataBaseModel:(NSManagedObject *)context WithObject:(NSObject *)object;

/**
 *  添加查询条件，子类实现
 *
 *  @param fetchRequest 查询请求
 *  @param object  生成查询语句的参数
 */
- (void)addQueryConditionForDescription:(NSFetchRequest *)fetchRequest WithObject:(NSObject *)object;

@end
