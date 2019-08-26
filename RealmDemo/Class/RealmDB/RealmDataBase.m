//
//  RealmDataBase.m
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/23.
//  Copyright © 2019 Boris. All rights reserved.
//

#import "RealmDataBase.h"

@implementation RealmDataBase

+ (RLMRealmConfiguration *)config
{
    static RLMRealmConfiguration *_config = nil;
    if (!_config) {
        
        RLMRealmConfiguration *config = [[RLMRealmConfiguration alloc] init];
        
        // 配置数据迁移的时候，如果有错误导致崩溃问题，会删除数据库重建，不会崩溃，但是数据会丢失。
        // 配置NO数据不会丢失，但是应用会崩溃，建议使用NO避免发生数据丢失的情况，可视情况而定...
        config.deleteRealmIfMigrationNeeded = NO;
        NSString *configPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/config.realm"];
        config.fileURL = [NSURL URLWithString:configPath];
        
        // model管理表，用来管理RLMObjects, 多个数据库可分开管理...
        NSString *path = [[NSBundle mainBundle] pathForResource:@"RealmTable" ofType:@"plist"];
        
        // 表名写在plist中
        NSMutableDictionary *tableDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        NSMutableArray *classArr = [NSMutableArray array];
        
        if (tableDic.allKeys == 0) {
            
            return nil;
        }
        
        for (id keys in tableDic.allKeys) {
            
            Class class = NSClassFromString(keys);
            [classArr addObject:class];
        }
        
        config.objectClasses = classArr;
        _config = config;
    }
    return _config;
}

+ (RealmDataBase *)db
{
    NSError *error ;
    RealmDataBase *rlmRealm = [RealmDataBase realmWithConfiguration:self.config error:nil];

    return rlmRealm;
}

+ (void)dataBaseMigration
{
    // 自定义 RLMRealmConfiguration 进行数据迁移
    RLMRealmConfiguration *config = self.config;
    //配置数据版本，每次项目发布加1
    config.schemaVersion = 1;
    config.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
        
        /**
         enumerateObjects:block: 遍历了存储在 Realm 文件中的每一个“RLMObject”对象
         将 RlmTextModel 修改为你需要新增参数的 RLMObject类...
         */
        [migration enumerateObjects:RlmTextModel.className block:^(RLMObject *oldObject, RLMObject *newObject) {
            
           /**
            只有在数据库架构版本为 2 的时候, 才添加一下属性：
            例如你的RLMObject类中新增了一个 address 的参数,x则需要在新发布版本时添加该参数:
            */
            if (oldSchemaVersion < 2) {

                newObject[@"address"] = @"";
            }
        }];
    };
    
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    /**
     现在我们已经成功更新了架构版本并且提供了迁移闭包，打开旧有的 Realm
     数据库会自动执行此数据迁移，然后成功进行访问
     */
    [RLMRealm realmWithConfiguration:config error:nil];
}

+ (BOOL)dropRealmIfNeed
{
    return [[NSFileManager defaultManager] removeItemAtPath:self.config.fileURL.path error:nil];
}


@end
