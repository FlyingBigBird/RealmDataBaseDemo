//
//  RealmDataBaseService.m
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/23.
//  Copyright © 2019 Boris. All rights reserved.
//

#import "RealmDataBaseService.h"


@implementation RealmDataBaseService

+ (BOOL)addRLMObject:(RLMObject *)obj {
    
    RealmDataBase *db = [RealmDataBase db];
    NSError *err;
    [db beginWriteTransaction];
    [db addOrUpdateObject:obj];
    [db commitWriteTransaction:&err];
    return err == nil;
}

+ (BOOL)addRLMObjects:(NSArray *)objects {
    
    RealmDataBase *db = [RealmDataBase db];
    NSError *err;
    [db beginWriteTransaction];
    [db addOrUpdateObjects:objects];
    [db commitWriteTransaction:&err];
    return err == nil;
}

+ (BOOL)deleteRLMObject:(RLMObject *)object {
    
    RealmDataBase *db = [RealmDataBase db];
    NSError *err;
    [db beginWriteTransaction];
    [db deleteObject:object];
    [db commitWriteTransaction:&err];
    return err == nil;
}

+ (BOOL)deleteRLMObjects:(RLMResults *)objects {
    
    RealmDataBase *db = [RealmDataBase db];
    NSError *err;
    [db beginWriteTransaction];
    [db deleteObjects:objects];
    [db commitWriteTransaction:&err];
    return err == nil;
}

+ (BOOL)updateRLMObject:(RLMObject *)obj andKey:(NSString *)key value:(NSString *)val {
    
    RealmDataBase *db = [RealmDataBase db];
    NSError *err;
    [db beginWriteTransaction];
    
    //获取主键key
    NSString *primaryKey = L([[obj class] primaryKey]);
    
    //获取主键value
    NSString *primaryValue = L([obj valueForKeyPath:primaryKey]);
    
    [[obj class] createOrUpdateInRealm:db withValue:@{primaryKey: primaryValue, key: val}];
    [db commitWriteTransaction:&err];
    return err == nil;
}

+ (BOOL)updateRLMObject:(RLMObject *)obj conditionObj:(NSDictionary *)dic {
    
    RealmDataBase *db = [RealmDataBase db];
    NSError *err;
    [db beginWriteTransaction];
    [[obj class] createOrUpdateInRealm:db withValue:dic];
    [db commitWriteTransaction:&err];
    return err == nil;
}

+ (RLMObject *)queryClass:(Class)classes withID:(NSString *)objectID {
    
    if (objectID.length <= 0) {
        return nil;
    }
    
    RealmDataBase *db = [RealmDataBase db];
    return [classes objectInRealm:db forPrimaryKey:objectID];
}

+ (RLMResults *)queryClass:(Class)classes predicateCondition:(NSString *)condition {
    
    RealmDataBase *db = [RealmDataBase db];
    NSPredicate *pre = [NSPredicate predicateWithFormat:condition];
    return [[classes allObjectsInRealm:db] objectsWithPredicate:pre];
}

+ (RLMResults *)queryClass:(Class)classes where:(NSString *)where {
    
    RealmDataBase *db = [RealmDataBase db];
    return [classes objectsInRealm:db where:where];
}


@end
