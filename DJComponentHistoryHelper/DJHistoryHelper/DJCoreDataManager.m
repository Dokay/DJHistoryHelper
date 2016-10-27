//
//  DJCoreDataManager.m
//  DJHistoryHelper
//
//  Created by Dokay on 13-11-12.
//  Copyright (c) 2013年 dj226. All rights reserved.
//

#import "DJCoreDataManager.h"

#define DataModelName @"dj226"

@implementation DJCoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

//+ (instancetype)sharedInstance
//{
//    static dispatch_once_t onceToken;
//    static id _singleInstance;
//    dispatch_once(&onceToken, ^{
//        _singleInstance = [self new];
//    });
//    return _singleInstance;
//}
- (id)init
{
    self = [self initWithSQliteName:DataModelName];
    if (self) {
        
    }
    return self;
}

- (id)initWithSQliteName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.sqliteName = name;
    }
    return self;
}

#pragma mark - Core Data 堆栈
//返回 被管理的对象上下文
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// 返回 持久化存储协调者
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = nil;
	storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",DataModelName]];
    
    NSError *error = nil;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
							 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        // Handle error
    }
    return _persistentStoreCoordinator;
}

//  返回 被管理的对象模型
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:DataModelName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

#pragma mark - 应用程序沙箱
// 返回应用程序Docment目录的NSURL类型
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSInteger)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			return 0;
        }
		return 1;
    }
	return 0;
}

@end
