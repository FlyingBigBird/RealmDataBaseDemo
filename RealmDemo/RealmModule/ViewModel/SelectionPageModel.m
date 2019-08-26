//
//  SelectionPageModel.m
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/23.
//  Copyright © 2019 Boris. All rights reserved.
//

#import "SelectionPageModel.h"

@implementation SelectionPageModel 

- (void) loadDataPath:(NSString *)url  finished:(DataFinisedCallBack)complete
{
    NSArray *array = [NSArray array];
    if (complete) {
        complete(array);
    }
}

@end
