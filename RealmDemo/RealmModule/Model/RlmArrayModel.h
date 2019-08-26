//
//  RlmArrayModel.h
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/26.
//  Copyright © 2019 Boris. All rights reserved.
//

#import "RLMObject.h"

@interface RlmArrayModel : RLMObject

@property NSString *opId;

@property NSString *opType;

@property NSData *data;

@end

RLM_ARRAY_TYPE(RlmArrayModel)
