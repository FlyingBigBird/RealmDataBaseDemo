//
//  RealmDataBase.h
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/23.
//  Copyright © 2019 Boris. All rights reserved.
//

#import "RLMRealm.h"

NS_ASSUME_NONNULL_BEGIN

@interface RealmDataBase : RLMRealm


/**
 初始化RLMRealm...

 @return 本地RLMRealm...
 */
+ (RealmDataBase *)db;


/**
 数据迁移, 在APP didFinishLaunching调用...
 */
+ (void)dataBaseMigration;

/**
 删除数据库...
 
 @return 是否删除成功...
 */
+ (BOOL)dropRealmIfNeed ;

@end

NS_ASSUME_NONNULL_END
