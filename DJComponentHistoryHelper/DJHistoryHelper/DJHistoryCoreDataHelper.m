//
//  DJHistoryCoreDataHelper.m
//  MengBaby
//
//  Created by Dokay on 14-7-28.
//  Copyright (c) 2014年 dj226. All rights reserved.
//

#import "DJHistoryCoreDataHelper.h"
#import "DJCoreDataManager.h"

@interface DJHistoryCoreDataHelper()

@property (nonatomic,strong) NSString *strEntityName;

@property (nonatomic,strong) DJCoreDataManager *DJCoreDataManager;

@end

@implementation DJHistoryCoreDataHelper

- (id)initWithName:(NSString *)strEntityName
{
    self = [super init];
    if (self != nil) {
        self.strEntityName = strEntityName;
    }
    return self;
}

/**
 *  由于CoreData的Context不是线程安全的，此处不再使用单例
 *
 *  @return
 */
- (DJCoreDataManager *)DJCoreDataManager
{
    if(_DJCoreDataManager == nil){
        _DJCoreDataManager = [DJCoreDataManager new];
    }
    return _DJCoreDataManager;
}

/**
 *  插入一条数据
 *
 *  @param item   待出入数据
 *  @param strKey 此处暂未使用
 */
- (void)insertItem:(NSObject *)item withPrimaryKey:(NSString *)strKey
{
    @synchronized(self.DJCoreDataManager.managedObjectContext){
        if (item != nil) {
            NSManagedObject *objCache = (NSManagedObject *)[self readFromLocalWithObject:item];
            if (objCache == nil) {
                //insert
                objCache = [NSEntityDescription insertNewObjectForEntityForName:self.strEntityName inManagedObjectContext:self.DJCoreDataManager.managedObjectContext];
            }
            
            [self updateDataBaseModel:objCache WithObject:item];
            [self save];
        }
    }
}

/**
 *  删除项
 *
 *  @param item 删除条件获取的参数，需要子类实现addQueryConditionForDescription: WithObject:
 */
- (void)removeItemBy:(NSObject *)item
{
    @synchronized(self.DJCoreDataManager.managedObjectContext){
        if (item != nil) {
            NSArray *listData = [self readArrayFromDataBase:item];
            if (listData.count > 0) {
                for (id object in listData) {
                    [self.DJCoreDataManager.managedObjectContext deleteObject:object];
                }
                [self save];
            }
        }
    }
}

/**
 *  查询
 *
 *  @param object 查询条件获取参数，需要子类实现addQueryConditionForDescription: WithObject:
 *
 *  @return 查询得到的第一条
 */
- (NSObject *)readFromLocalWithObject:(NSObject *)object
{
    @synchronized(self.DJCoreDataManager.managedObjectContext){
        NSArray *arrData = [self readArrayFromDataBase:object];
        if (arrData.count > 0) {
            return arrData[0];
        }
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
    @synchronized(self.DJCoreDataManager.managedObjectContext){
        NSArray *arrData = [self readArrayFromDataBase:nil];
        return arrData;
    }
}

/**
 *  删除所有数据
 */
- (void)removeAllItem
{
    @synchronized(self.DJCoreDataManager.managedObjectContext){
        NSArray *listData = [self readArrayFromDataBase:nil];
        if (listData.count > 0) {
            for (id object in listData) {
                [self.DJCoreDataManager.managedObjectContext deleteObject:object];
            }
            [self save];
        }
    }
}

- (void)save
{
    //    NSError *savingError = nil;
    //    if ([self.DJCoreDataManager.managedObjectContext save:&savingError]){
    //        NSLog(@"Dokay-Message:%@",savingError.description);
    //    }
    @synchronized(self.DJCoreDataManager.managedObjectContext){
        [self.DJCoreDataManager saveContext];
    }
}

- (NSArray *)readArrayFromDataBase:(NSObject *)object
{
    @synchronized(self.DJCoreDataManager.managedObjectContext){
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:self.strEntityName  inManagedObjectContext:self.DJCoreDataManager.managedObjectContext];
        [fetchRequest setEntity:entity];
        [fetchRequest setFetchBatchSize:10];
        
        [self addQueryConditionForDescription:fetchRequest WithObject:object];
        
        NSError *error = nil;
        NSArray *listData = [self.DJCoreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        return listData;
    }
}

/**
 *  填充数据库对象，
 *
 *  @param context 待填充的数据库对象
 *  @param object  填充的参数
 */
- (void)updateDataBaseModel:(NSManagedObject *)context WithObject:(NSObject *)object
{
    
}

- (void)addQueryConditionForDescription:(NSFetchRequest *)fetchRequest WithObject:(NSObject *)object
{
    //    Demo
    //    if ([object isKindOfClass:[NSString class]]) {
    //        NSString *strWhere = (NSString *)object;
    //        if (strWhere.length > 0) {
    //            NSPredicate * qcondition= [NSPredicate predicateWithFormat:strWhere];
    //            [fetchRequest setPredicate:qcondition];
    //        }
    //    }
}

@end
