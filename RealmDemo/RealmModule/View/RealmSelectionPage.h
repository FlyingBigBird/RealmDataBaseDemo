//
//  RealmSelectionPage.h
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/23.
//  Copyright © 2019 Boris. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface RealmSelectionPage : UIView

@property (nonatomic, strong) UITableView *table;

typedef void (^SelectItemBlock)(NSIndexPath *selectIndexPath);
@property (nonatomic, copy) SelectItemBlock itemSelected;

- (instancetype)initWithFrame:(CGRect)frame selected:(SelectItemBlock)selected;

@end

NS_ASSUME_NONNULL_END
