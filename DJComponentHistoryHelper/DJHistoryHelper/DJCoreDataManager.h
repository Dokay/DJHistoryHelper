//
//  DJCoreDataManager.h
//  DJHistoryHelper
//
//  Created by Dokay on 13-11-12.
//  Copyright (c) 2013年 dj226. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DJCoreDataManager : NSObject

//被管理的对象上下文
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//被管理的对象模型
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//持久化存储协调者
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) NSString *sqliteName;

//+ (instancetype)sharedInstance;
- (id)initWithSQliteName:(NSString *)name;

//- (NSURL *)applicationDocumentsDirectory;
- (NSInteger)saveContext;

@end
