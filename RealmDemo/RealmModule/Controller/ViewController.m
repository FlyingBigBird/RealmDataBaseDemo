//
//  ViewController.m
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/23.
//  Copyright © 2019 Boris. All rights reserved.
//

#import "ViewController.h"
#import "RealmSelectionPage.h"
#import "OperationController.h"

@interface ViewController ()

@property (nonatomic, strong) RealmSelectionPage *homePage;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.homePage.table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    
    self.title = @"realmDB";

    __weak typeof(self)weakSelf = self;
    self.homePage = [[RealmSelectionPage alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavBar_H - StatusBar_H) selected:^(NSIndexPath * _Nonnull selectIndexPath) {
        
        [weakSelf selectItemAtIndex:selectIndexPath];
    }];
    [self.view addSubview:self.homePage];
    
}
- (void)selectItemAtIndex:(NSIndexPath *)indexPath
{
    OperationController *opVC = [[OperationController alloc] init];
    opVC.opType = indexPath.row;
    [self.navigationController pushViewController:opVC animated:YES];
}

@end
