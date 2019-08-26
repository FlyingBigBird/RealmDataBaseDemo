//
//  ShowView.m
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/23.
//  Copyright © 2019 Boris. All rights reserved.
//

#import "ShowView.h"

@interface ShowView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *realmArr;

@end

@implementation ShowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.itemArr = [NSArray array];
        self.realmArr = [NSArray array];

        [self addShowViewUI];
    }
    return self;
}

- (void)addShowViewUI
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

        CGFloat imgM = 10;
        CGFloat imgWH = (SCREEN_WIDTH - imgM * 3) / 3;
        self.imgL = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 2 - imgWH / 2, imgWH, imgWH)];
        [self addSubview:self.imgL];
        self.imgL.contentMode = UIViewContentModeScaleAspectFill;
        self.imgL.clipsToBounds = YES;
        self.imgL.hidden = YES;
        
        self.imgC = [[UIImageView alloc] initWithFrame:CGRectMake(imgWH * 1 + imgM * 1, SCREEN_HEIGHT / 2 - imgWH / 2, imgWH, imgWH)];
        [self addSubview:self.imgC];
        self.imgC.contentMode = UIViewContentModeScaleAspectFill;
        self.imgC.clipsToBounds = YES;
        self.imgC.hidden = YES;
        
        self.imgR = [[UIImageView alloc] initWithFrame:CGRectMake(imgWH * 2 + imgM * 2, SCREEN_HEIGHT / 2 - imgWH / 2, imgWH, imgWH)];
        [self addSubview:self.imgR];
        self.imgR.contentMode = UIViewContentModeScaleAspectFill;
        self.imgR.clipsToBounds = YES;
        
        self.imgR.hidden = YES;
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
    return self.realmArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const reUseString = @"defaultCellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reUseString];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reUseString];
    }
    
    RlmTextModel *model = self.realmArr[indexPath.row];
    
    cell.textLabel.hidden = NO;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.text = FORMAT(@"姓名: %@    年龄: %@岁    性别: %@",model.name,model.age,model.sex);
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)setItemArr:(NSArray *)itemArr
{
    self.realmArr = itemArr;
    [self.table reloadData];
}


@end
