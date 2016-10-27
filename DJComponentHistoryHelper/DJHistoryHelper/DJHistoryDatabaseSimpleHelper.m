//
//  DJHistoryDatabaseSimpleHelper.m
//  DJHistoryHelper
//
//  Created by Dokay on 12/9/14.
//  Copyright (c) 2014 dj226. All rights reserved.
//

#import "DJHistoryDatabaseSimpleHelper.h"

#define SaveValue @"SaveValue"

@implementation DJHistoryDatabaseSimpleHelper

- (NSMutableDictionary *)dicColumProperty
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:@"text",SaveValue, nil];
}

- (void)insertItem:(NSObject *)item withPrimaryKey:(NSString *)strKey
{
    if ([item isKindOfClass:[NSDictionary class]]) {
        NSError * error;
        NSData * data = [NSJSONSerialization dataWithJSONObject:item options:0 error:&error];
        if (error) {
            NSLog(@"ERROR, faild to get json data");
            return;
        }
        NSString * jsonString = [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
        
        NSDictionary *dicToSave = @{
                                    SaveValue:jsonString
                                    };
        
        [super insertItem:dicToSave withPrimaryKey:strKey];
    }else{
        
    }
}

- (NSObject *)processValue:(NSString *)strValue WithKey:(NSString *)strKey
{
    //结果处理成dictionary
    if([strKey isEqualToString:SaveValue]){
        NSError * error;
        NSData * data = [strValue dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dicToReturn = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            NSLog(@"ERROR, faild to get json data");
            return dicToReturn;
        }
    }
    return strValue;
}


- (NSArray *)readArrayFromDataBase:(NSObject *)object
{
    NSArray *arrSource = [super readArrayFromDataBase:object];
    NSMutableArray *arrDes = [NSMutableArray arrayWithCapacity:arrSource.count];
    for (NSDictionary *dicValue in arrSource) {
        NSString *strResult = [dicValue valueForKey:SaveValue];
        NSError * error;
        NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData: [strResult dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers
                                          error: &error];
        if (error) {
            NSLog(@"ERROR, faild to get json data");
            return nil;
        }
        [arrDes addObject:dicResult];
    }
    
    return arrDes;
}

@end
