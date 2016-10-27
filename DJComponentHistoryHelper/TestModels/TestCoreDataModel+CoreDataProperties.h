//
//  TestCoreDataModel+CoreDataProperties.h
//  DJHistoryHelper
//
//  Created by Dokay on 16/4/22.
//  Copyright © 2016年 dj226. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TestCoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestCoreDataModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *code;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
