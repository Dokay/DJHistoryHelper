//
//  DJHistoryCoreDataDemoHelper.m
//  DJHistoryHelper
//
//  Created by Dokay on 16/4/22.
//  Copyright © 2016年 dj226. All rights reserved.
//

#import "DJHistoryCoreDataDemoHelper.h"

@implementation DJHistoryCoreDataDemoHelper
- (void)updateDataBaseModel:(NSManagedObjectContext *)context WithObject:(NSObject *)object
{
    TestCoreDataModel *expressCache = (TestCoreDataModel *)context;
    NSDictionary *newValue = (NSDictionary *)object;
    if (context != nil && newValue != nil) {
        expressCache.name     = [newValue valueForKey:@"name"];
        expressCache.code     = [newValue valueForKey:@"code"];
    }
}

- (void)addQueryConditionForDescription:(NSFetchRequest *)fetchRequest WithObject:(NSObject *)object
{
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *newValue = (NSDictionary *)object;
        NSString *strWhere = [self getSQLWhereFromDic:newValue];
        if (strWhere.length > 0) {
            NSPredicate * qcondition= [NSPredicate predicateWithFormat:strWhere];
            [fetchRequest setPredicate:qcondition];
        }
    }
    
    if ([object isKindOfClass:[NSString class]]) {
        NSString *strWhere = [NSString stringWithFormat:@"code = '%@'",(NSString *)object];
        if (strWhere.length > 0) {
            NSPredicate * qcondition= [NSPredicate predicateWithFormat:strWhere];
            [fetchRequest setPredicate:qcondition];
        }
    }
}

- (NSString *)getSQLWhereFromDic:(NSDictionary *)newValue
{
    NSString *strExpressCode = [newValue valueForKey:@"code"];
    NSString *strExid = [newValue valueForKey:@"exid"];
    NSString *strCom = [newValue valueForKey:@"com"];
    if ([strExpressCode length] > 0) {
        NSString *strWhere = @"";
        if (strExid) {
            strWhere = [NSString stringWithFormat:@"code = '%@' AND exid='%@'",strExpressCode,strExid];
        }else if(strCom){
            strWhere = [NSString stringWithFormat:@"code = '%@' AND com='%@'",strExpressCode,strCom];
        }else{
            strWhere = [NSString stringWithFormat:@"code = '%@'",strExpressCode];
        }
        return strWhere;
    }
    return @"";
}

@end
