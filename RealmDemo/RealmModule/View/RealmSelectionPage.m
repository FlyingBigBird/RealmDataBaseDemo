//
//  RealmSelectionPage.m
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/23.
//  Copyright © 2019 Boris. All rights reserved.
//

#import "RealmSelectionPage.h"
#import "SelectionPageModel.h"

@interface RealmSelectionPage () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *itemArr;

@end

@implementation RealmSelectionPage

- (instancetype)initWithFrame:(CGRect)frame selected:(SelectItemBlock)selected
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.itemSelected = selected;
        [self showRealmSelectionPageUI];
    }
    return self;
}

- (void)showRealmSelectionPageUI
{
    self.table.backgroundColor = [UIColor whiteColor];
    
}
- (UITableView *)table
{
    if (!_table) {
        
        _table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _table.contentInsetAdjustmentBehavior =  UIScrollViewContentInsetAdjustmentNever;
        }
        
        _table.dataSource = self;
        _table.delegate = self;
        
        [self addSubview:_table];
        _table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
        _table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
    }
    return _table;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const reUseString = @"defaultCellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reUseString];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reUseString];
    }
    
    NSString *getRow = LInteger(indexPath.row);
    
    cell.textLabel.hidden = NO;
    cell.textLabel.text = [self.itemArr[indexPath.row] objectForKey:getRow];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.itemSelected) {
        
        self.itemSelected(indexPath);
    }
}

- (NSMutableArray *)itemArr
{
    if (!_itemArr) {
        
        _itemArr = [NSMutableArray array];
        
        NSDictionary *addDic         =   @{@"0":@"新增文本"};
        NSDictionary *changeDic      =   @{@"1":@"修改文本"};
        NSDictionary *searchDic      =   @{@"2":@"查询文本"};
        NSDictionary *deleteDic      =   @{@"3":@"删除文本"};
        
        NSDictionary *picDic         =   @{@"4":@"图片存取"};
        NSDictionary *arrayDic       =   @{@"5":@"数组存取"};

        [_itemArr addObject:addDic];
        [_itemArr addObject:changeDic];
        [_itemArr addObject:searchDic];
        [_itemArr addObject:deleteDic];
        [_itemArr addObject:picDic];
        [_itemArr addObject:arrayDic];

    }
    return _itemArr;
}

@end
