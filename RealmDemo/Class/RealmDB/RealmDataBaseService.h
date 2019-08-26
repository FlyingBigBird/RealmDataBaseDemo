//
//  RealmDataBaseService.h
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/23.
//  Copyright © 2019 Boris. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 realm使用：不能跨线程访问RLMObject对象，官方要求，否则会crash 对于具备特定标识符的内存中 Realm 数据库而言，如果所有相关的实例引用均被移除的话，那么该 Realm 数据库当中的所有数据都会被删除。建议在应用生命周期内对内存中 Realm 数据库进行强引用。（对于磁盘 Realm 数据库而言，这个操作是不必要的。）
 */
@interface RealmDataBaseService : NSObject

/**
 添加：部分添加
 
 @param obj RLMObject实体
 @return 添加后的状态,成功or失败
 */
+ (BOOL)addRLMObject:(RLMObject *)obj;

/**
 添加：批量添加
 
 @param objects RLMObject集合
 @return 添加后的状态,成功or失败
 */
+ (BOOL)addRLMObjects:(NSArray *)objects;

/**
 删除某一个RLMObject实体
 
 @param object RLMObject实体
 @return 删除后的状态,成功or失败
 */
+ (BOOL)deleteRLMObject:(RLMObject *)object;

/**
 删除所有RLMObject实体
 
 @param objects 实体集合
 @return 删除后的状态,成功or失败
 */
+ (BOOL)deleteRLMObjects:(RLMResults *)objects;

/**
 更新：通过主键更新，修改RLMObject某个属性值
 
 @param obj RLMObject实体,更改前的
 @param key 属性字段
 @param val 属性值
 @return 修改后的状态,成功or失败
 */
+ (BOOL)updateRLMObject:(RLMObject *)obj andKey:(NSString *)key value:(NSString *)val;

/**
 更新：通过主键更新，修改RLMObject多个属性值
 
 @param obj RLMObject实体,更改前的
 @param dic 更改条件集合：{主键key:主键value, key1:value1, key2:value2...}
 @return 修改后的状态,成功or失败
 */
+ (BOOL)updateRLMObject:(RLMObject *)obj conditionObj:(NSDictionary *)dic;

/**
 根据主键查询单个实体
 
 @param classes 实体类名：RLMObject的子类
 @param objectID 主键
 @return 实体 RLMObject的子类
 */
+ (RLMObject *)queryClass:(Class)classes withID:(NSString *)objectID;

/**
 通过预言查询
 
 @param classes 实体类名：RLMObject的子类
 @param condition 查询条件，转预言查询
 @return 实体列表: RLMObject的子类的集合
 */
+ (RLMResults *)queryClass:(Class)classes predicateCondition:(NSString *)condition;

/**
 通过where查询条件
 
 @param classes 实体类名：RLMObject的子类
 @param where 查询条件 where查询
 @return 实体列表: RLMObject的子类的集合
 */
+ (RLMResults *)queryClass:(Class)classes where:(NSString *)where;

@end

NS_ASSUME_NONNULL_END
