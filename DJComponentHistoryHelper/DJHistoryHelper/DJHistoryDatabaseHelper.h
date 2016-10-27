//
//  DJHistoryDatabaseHelper.h
//  DJHistoryHelper
//
//  Created by Dokay on 14-7-29.
//  Copyright (c) 2014年 dj226. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJHistoryBase.h"
#define HistoryColumName @"HistoryColumName"
#define HistoryColumType @"HistoryColumType"

@interface DJHistoryDatabaseHelper : NSObject<DJHistoryDelegate>

/**
 *  表的内容详情，列名以及类型，子类实现
 */
@property (nonatomic, strong) NSMutableDictionary *dicColumProperty;

/**
 *  生成查询语句，子类酌情实现
 *
 *  @param object 查询语句依赖对象
 *
 *  @return 查询语句
 */
- (NSString *)getQueryWithObject:(NSObject *)object;

/**
 *  具体升级数据的操作，子类继承实现
 *
 *  @param oldVersion
 *  @param newVersion
 */
- (void) updateTableFromVersion:(NSString *)oldVersion ToVersion:(NSString *)newVersion;

/**
 *  文件存储路径，子类可overwrite
 *
 *  @return
 */
- (NSString *)getFilePath;

/**
 *  子类可对每一行的结果进行简单处理
 *
 *  @param strValue 初始值
 *  @param strKey   列名
 *
 *  @return 处理结果
 */
- (NSObject *)processValue:(NSString *)strValue WithKey:(NSString *)strKey;

- (NSArray *)readArrayFromDataBase:(NSObject *)object;

@end
