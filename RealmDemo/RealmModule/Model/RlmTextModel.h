//
//  RlmTextModel.h
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/23.
//  Copyright © 2019 Boris. All rights reserved.
//

@interface RlmTextModel : RLMObject

/**
 RLMObject 最好是不用任何修饰类型类型, 例如：  @property NSString *name
 */

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *age;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

RLM_ARRAY_TYPE(RlmTextModel)

