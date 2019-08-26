//
//  SelectionPageModel.h
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/23.
//  Copyright © 2019 Boris. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectionPageModel : NSObject

typedef void (^DataFinisedCallBack)(NSArray *data);
@property (nonatomic, copy) DataFinisedCallBack finishData;

- (void) loadDataPath:(NSString *)url  finished:(DataFinisedCallBack)complete;

@end

NS_ASSUME_NONNULL_END
