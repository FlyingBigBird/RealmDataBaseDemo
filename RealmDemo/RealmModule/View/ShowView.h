//
//  ShowView.h
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/23.
//  Copyright © 2019 Boris. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowView : UIView

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIImageView *imgL;
@property (nonatomic, strong) UIImageView *imgC;
@property (nonatomic, strong) UIImageView *imgR;


@property (nonatomic, strong) NSArray *itemArr;


@end

NS_ASSUME_NONNULL_END
