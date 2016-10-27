//
//  DJHistoryCoreDataHelper.m
//  DJHistoryHelper
//
//  Created by Dokay on 14-7-28.
//  Copyright (c) 2014年 dj226. All rights reserved.
//

#import "DJHistoryDatabaseHelper.h"
#import "sqlite3.h"

#define PrimaryKey @"PrimaryKey"

@interface DJHistoryDatabaseHelper()
{
    sqlite3 *_database;
}
@property (nonatomic,strong) NSString *strTableName;


@end

@implementation DJHistoryDatabaseHelper

- (id)initWithName:(NSString *)strTableName
{
    self = [super init];
    if (self != nil) {
        self.strTableName = strTableName;
        
        [self openTable];
        
        [self updateTable];
    }
    return self;
}

/**
 *  插入一条数据
 *
 *  @param item   待存入数据
 *  @param strKey
 */
- (void)insertItem:(NSObject *)item withPrimaryKey:(NSString *)strKey
{
    if (item != nil && strKey.length > 0) {
        
        NSDictionary *dicParam = (NSDictionary *)item;
        if (dicParam != nil) {
            
            NSMutableString *arrValues = [NSMutableString new];
            NSMutableString *arrColums = [NSMutableString new];
            
            for (NSString *strColumName in self.dicColumProperty) {
                if ([dicParam valueForKey:strColumName] != nil) {
                    [arrColums appendString:[NSString stringWithFormat:@"%@,",strColumName]];
                    [arrValues appendString:[NSString stringWithFormat:@"'%@',",[dicParam valueForKey:strColumName]]];
                }
            }
            
            if (arrValues.length > 0) {
                [self removeItemBy:strKey];
                
                [arrValues appendString:[NSString stringWithFormat:@"'%@'",strKey]];
                [arrColums appendString:[NSString stringWithFormat:@"%@",PrimaryKey]];
                //        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO tb_user_action (act,dobj,iobj,stat,end,ctid) VALUES ('%@','%@','%@','%@','%@','%@')",[dict valueForKey:kParamAction],[dict valueForKey:kParamDirectObj],[dict valueForKey:kParamIndirectObj],[dict valueForKey:kParamStartTime],[dict valueForKey:kParamEndTime],[dict valueForKey:kParamCityID]];
                //        [self executSQLOperation:insertSQL];
                
                NSString *strInsertSql = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",self.strTableName,arrColums,arrValues];
                [self executSQLOperation:strInsertSql];
            }
        }
    }
}

/**
 *  删除项
 *
 *  @param item 删除条件获取的参数，需要子类实现getQueryWithObject:
 */
- (void)removeItemBy:(NSObject *)item
{
    NSString *strQueryValue = (NSString *)item;
    if (strQueryValue.length > 0) {
        NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ == '%@'",self.strTableName,PrimaryKey,strQueryValue];
        [self executSQLOperation:deleteSQL];
    }
}

/**
 *  查询
 *
 *  @param object 查询条件获取参数，需要子类实现getQueryWithObject:
 *
 *  @return 查询得到的第一条
 */
- (NSObject *)readFromLocalWithObject:(NSObject *)object
{
    NSArray *arrData = [self readArrayFromDataBase:object];
    if (arrData.count > 0) {
        return arrData[0];
    }
    return nil;
}

/**
 *  获取全部数据
 *
 *  @return 全部数据
 */
- (NSArray *)readFromLoacl
{
    NSArray *arrData = [self readArrayFromDataBase:nil];
    return arrData;
}

/**
 *  删除所有数据
 */
- (void)removeAllItem
{
    NSString *strSql = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@",self.strTableName];
    [self executSQLOperation:strSql];
}

- (NSArray *)readArrayFromDataBase:(NSObject *)object
{
    NSMutableArray *arrRetval = [[NSMutableArray alloc] init];
    NSString *query = [self getQueryWithObject:object];
    if (query.length > 0) {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil)==SQLITE_OK) {
            while (sqlite3_step(statement)==SQLITE_ROW) {
                NSDictionary *dicValue = [self assembleResultWithStateMent:statement];
                [arrRetval addObject:dicValue];
            }
            sqlite3_finalize(statement);
        }
    }
    
    return arrRetval;
}

- (BOOL)openTable
{
    if (sqlite3_open([[self getFilePath] UTF8String], &_database)==SQLITE_OK) {
        //create the table
        NSMutableString *strSqlTable = [NSMutableString new];
        if (self.dicColumProperty != nil) {
            
            for (NSString *strColumName in self.dicColumProperty) {
                [strSqlTable appendString:[NSString stringWithFormat:@"%@ %@,",strColumName,[self.dicColumProperty valueForKey:strColumName]]];
            }
            
            if (strSqlTable.length > 0) {
                [strSqlTable appendString:[NSString stringWithFormat:@"%@ text",PrimaryKey]];
            }
        }
        
        if (strSqlTable.length > 0) {
            //            NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS tb_disclose_upload (userid text,uploadtime text,imagepath text,remark text,cityname text,username text,telphone text,verifycode text,uploadid text,isactive text)";
            
            NSString *strSqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@)",self.strTableName,strSqlTable];
            return [self executSQLOperation:strSqlCreateTable];
        }else{
            NSLog(@"建表失败，类型和名称不对");
            return NO;
        }
    }
    return YES;
}

- (BOOL)executSQLOperation:(NSString *)strSQL
{
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [strSQL UTF8String], -1, &statement, nil)==SQLITE_OK) {
        if (sqlite3_step(statement)==SQLITE_DONE) {
            sqlite3_finalize(statement);
            return TRUE;
        }else {
            sqlite3_finalize(statement);
            return FALSE;
        }
    }else {
        return FALSE;
    }
}

- (NSString *)getFilePath
{
//    NSString *strDocPath = [FilePathHelper getHistorySqliteFilePath];
    NSString *strDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *strDocPath = [strDirectory stringByAppendingPathComponent:@"HistorySqlite"];

    BOOL bDirectory = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:strDocPath isDirectory:&bDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:strDocPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *strFilePath = [NSString stringWithFormat:@"%@/WCCHistoryDatabase.sqlite3",strDocPath];
    if (![[NSFileManager defaultManager]fileExistsAtPath:strFilePath]) {
        [[NSFileManager defaultManager] createFileAtPath:strFilePath contents:nil attributes:nil];
    }
    return strFilePath;
}

/**
 *  读取一行数据后封装
 *
 *  @param statement 数据库对象
 *
 *  @return 一条返回结果
 */
- (NSDictionary *)assembleResultWithStateMent:(sqlite3_stmt *)statement
{
    int i = 0;
    NSMutableDictionary *dicToReturn = [NSMutableDictionary new];
    for (NSString *strColumName in self.dicColumProperty) {
        char *charValue = (char *) sqlite3_column_text(statement, i);
        NSString *strValue = [[NSString alloc] initWithUTF8String:charValue];
        NSObject *objResult= [self processValue:strValue WithKey:strColumName];
        [dicToReturn setValue:objResult forKey:strColumName];
        i++;
    }
    return dicToReturn;
}

/**
 *  子类可对每一行的结果进行简单处理
 *
 *  @param strValue 初始值
 *  @param strKey   列名
 *
 *  @return 处理结果
 */
- (NSObject *)processValue:(NSString *)strValue WithKey:(NSString *)strKey
{
    //默认不处理
    return strValue;
}

/**
 *  升级数据库
 */
- (void)updateTable
{
    NSString *strTableVersionKey = [NSString stringWithFormat:@"Table_%@_Version",self.strTableName];
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults]valueForKey:strTableVersionKey];
    
    NSDictionary *bundleDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [bundleDic objectForKey:@"CFBundleVersion"];
    
    [self updateTableFromVersion:oldVersion ToVersion:currentVersion];
  
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:strTableVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableDictionary *)dicColumProperty
{
    if (_dicColumProperty == nil) {
        _dicColumProperty = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"text",@"name",@"text",@"num", nil];
    }
    return _dicColumProperty;
}

- (NSString *)getQueryWithObject:(NSObject *)object
{
    NSString *strQuery;
    
    if (object == nil) {
        //默认返回整个表
        strQuery = [NSString stringWithFormat:@"SELECT * FROM %@ order by rowid desc",self.strTableName];
    }else if([object isKindOfClass:[NSString class]]){
        //string 类型认为是查主键
        strQuery = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE '%%%@%%' order by rowid desc",self.strTableName,PrimaryKey,(NSString *)object];
    }
    
    
    return strQuery;
}

/**
 *  具体升级数据的操作，子类继承实现
 *
 *  @param oldVersion
 *  @param newVersion
 */
- (void) updateTableFromVersion:(NSString *)oldVersion ToVersion:(NSString *)newVersion
{
    //简单实现方式，可以将旧的数据库内容读出，删除旧表，插入到新表中。
}


@end
