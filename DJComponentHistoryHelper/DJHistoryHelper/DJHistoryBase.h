//
//  DJHistoryBase.h
//  DJHistoryHelper
//
//  Created by Dokay on 14-7-28.
//  Copyright (c) 2014年 dj226. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DJLOCK(...) dispatch_semaphore_signal(_lock); \
__VA_ARGS__; \
dispatch_semaphore_signal(_lock);

#define DJSignalLock dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER)
#define DJSIgnalUnlock dispatch_semaphore_signal(_lock);


@protocol DJHistoryDelegate <NSObject>

/**
 *  初始化HistoryHelper
 *
 *  @param strName Plist文件名/Coredata的实体名/sqlite的表名
 *
 *  @return HistoryHelper 实例
 */
- (id)initWithName:(NSString *)strName;

/**
 *  往历史记录中插入一条数据
 *
 *  @param item   将要插入的数据
 *  @param strKey 将要插入数据的”主键“值，以后做查询要用到
 */
- (void)insertItem:(NSObject *)item withPrimaryKey:(NSString *)strKey;

/**
 *  从本地历史记录中读取一条数据
 *
 *  @param object 依赖的”主键“值，同插入数据时
 *
 *  @return 历史记录中读出的对象
 */
- (NSObject *)readFromLocalWithObject:(NSObject *)object;

/**
 *  读取所有的历史记录
 *
 *  @return 历史记录数组
 */
- (NSArray *)readFromLoacl;

/**
 *  删除一套数据
 *
 *  @param object 依赖的”主键“值，同插入数据时。
 */
- (void)removeItemBy:(NSObject *)object;

/**
 *  删除该历史记录中所有数据
 */
- (void)removeAllItem;

@end
