//
//  DJHistoryPlistHelper.m
//  MengBaby
//
//  Created by Dokay on 14-7-28.
//  Copyright (c) 2014年 dj226. All rights reserved.
//

#import "DJHistoryPlistHelper.h"

#define HistoryPrimaryKey @"HistoryPrimaryKey" //存储数据项的“主键”

@interface DJHistoryPlistHelper()

@property (nonatomic,strong) NSString       *strFileName;
@property (nonatomic,strong) NSMutableArray *arrData;
@end

@implementation DJHistoryPlistHelper

- (id)initWithName:(NSString *)strFileName;
{
    self = [super init];
    if (self) {
        if (strFileName.length > 0) {
            self.strFileName = strFileName;
        }else{
            NSLog(@"Dokay-Message:DJHistoryPlistHelper strFileName nil");
        }
    }
    return self;
}

/**
 *  添加数据项
 *
 *  @param item   item 添加参数，要求是dictionary,若是需要Model类型的，需要子类继承后修改
 *  @param strKey 存储的主键
 */
- (void)insertItem:(NSObject *)item withPrimaryKey:(NSString *)strKey
{
    NSDictionary *dicParam = (NSDictionary *)item;
    if (dicParam != nil && strKey.length > 0) {
        @synchronized(self.arrData)
        {
            [self removeItemBy:strKey];
            
            NSMutableDictionary *dicToInsert = [NSMutableDictionary dictionaryWithDictionary:dicParam];
            [dicToInsert setValue:strKey forKey:HistoryPrimaryKey];
            [self.arrData insertObject:dicToInsert atIndex:0];
            [self save];
        }
    }
}

/**
 *  删除数据项
 *
 *  @param item ”主键“，string 类型
 */
- (void)removeItemBy:(NSObject *)item
{
    NSString *strSearchKey = (NSString *)item;
    if (strSearchKey.length > 0) {
        @synchronized(self.arrData)
        {
            NSMutableArray *arrResult = [NSMutableArray new];
            for (NSDictionary *dicItem in self.arrData) {
                if (![[dicItem valueForKey:HistoryPrimaryKey] isEqual:strSearchKey]) {
                    [arrResult addObject:dicItem];
                }
            }
            _arrData = arrResult;
            [self save];
        }
    }
}

/**
 *  查询
 *
 *  @param object ”主键“，string 类型
 *
 *  @return 查询得到的结果，NSDictionary 类型
 */
- (NSObject *)readFromLocalWithObject:(NSObject *)object
{
    NSString *strSearchKey = (NSString *)object;
    if (strSearchKey.length > 0) {
        @synchronized(self.arrData)
        {
            for (NSDictionary *dicItem in self.arrData) {
                if ([[dicItem valueForKey:HistoryPrimaryKey] isEqual:strSearchKey]) {
                    return dicItem;
                }
            }
        }
    }
    return nil;
}

/**
 *  返回所有数据
 *
 *  @return
 */
- (NSArray *)readFromLoacl
{
    return self.arrData;
}

- (void)save
{
    NSString *strFilePath = [self getFilePath];
    [self.arrData writeToFile:strFilePath atomically:YES];
}

- (void)removeAllItem
{
    [self.arrData removeAllObjects];
    NSString *strFilePath = [self getFilePath];
    [[NSFileManager defaultManager] removeItemAtPath:strFilePath error:nil];
}

- (NSString *)getFilePath
{
    NSString *strDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *strDocPath = [strDirectory stringByAppendingPathComponent:@"HistoryPlist"];
    BOOL bDirectory = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:strDocPath isDirectory:&bDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:strDocPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *strFilePath = [NSString stringWithFormat:@"%@/%@.plist",strDocPath,self.strFileName];
    NSLog(@"path3:%@",strFilePath);
    if (![[NSFileManager defaultManager]fileExistsAtPath:strFilePath]) {
        [[NSFileManager defaultManager] createFileAtPath:strFilePath contents:nil attributes:nil];
    }
    return strFilePath;
}

- (NSMutableArray *)arrData
{
    if (_arrData == nil) {
        _arrData = [NSMutableArray arrayWithContentsOfFile:[self getFilePath]];
    }
    if (_arrData == nil) {
        _arrData = [NSMutableArray new];
    }
    return _arrData;
}

@end
