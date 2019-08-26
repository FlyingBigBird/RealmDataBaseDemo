//
//  RlmImgModel.h
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/26.
//  Copyright © 2019 Boris. All rights reserved.
//

#import "RLMObject.h"

@interface RlmImgModel : RLMObject

@property (nonatomic, strong) NSString *opId;

@property (nonatomic, strong) NSString *opType;

@property NSData *imgData;

@end

RLM_ARRAY_TYPE(RlmImgModel)
