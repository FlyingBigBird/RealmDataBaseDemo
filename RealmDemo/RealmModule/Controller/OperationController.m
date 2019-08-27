//
//  OperationController.m
//  RealmDemo
//
//  Created by BaoBaoDaRen on 2019/8/23.
//  Copyright © 2019 Boris. All rights reserved.
//

#import "OperationController.h"
#import "ShowView.h"
#import "RlmImgModel.h"
#import "RlmArrayModel.h"

@interface OperationController ()

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) ShowView       *showV;
@property (nonatomic, strong) UIButton       *rightBtn;

@end

@implementation OperationController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self showNavUI];
    
    switch (self.opType)
    {
        case RLMOperationAddMessage:
        {
            [self addMsg];
            self.title = @"新增数据";
            [self.rightBtn setTitle:@"新增" forState:UIControlStateNormal];

            break;
        } case RLMOperationUpdateMessage:
        {
            [self updateMsg];
            self.title = @"修改数据";
            [self.rightBtn setTitle:@"修改" forState:UIControlStateNormal];

            break;
        } case RLMOperationSearchMessage:
        {
            [self searchMsg];
            self.title = @"查询数据";
            [self.rightBtn setTitle:@"查询" forState:UIControlStateNormal];

            break;
        } case RLMOperationDeleteMessage:
        {
            [self deleteMsg];
            self.title = @"删除数据";
            [self.rightBtn setTitle:@"删除" forState:UIControlStateNormal];

            break;
        } case RLMOperationImage:
        {
            self.showV.table.hidden = YES;
            self.showV.imgL.hidden = NO;
            self.showV.imgC.hidden = NO;
            self.showV.imgR.hidden = NO;

            [self opPic];
            self.title = @"单张图片分别存储查询";
            [self.rightBtn setTitle:@"显示" forState:UIControlStateNormal];

            break;
        } case RLMOperationArray:
        {
            self.showV.table.hidden = YES;
            self.showV.imgL.hidden = NO;
            self.showV.imgC.hidden = NO;
            self.showV.imgR.hidden = NO;

            [self opArray];
            self.title = @"保存数组并查询";
            [self.rightBtn setTitle:@"显示" forState:UIControlStateNormal];

            break;
        }
        default:
            break;
    }
}
- (void)showNavUI
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.showV.table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [self.rightBtn setTitle:@"设置" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(showClickedActions:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.showV = [[ShowView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavBar_H - StatusBar_H)];
    [self.view addSubview:self.showV];
    
}
- (void)showClickedActions:(UIButton *)sender
{
    switch (self.opType)
    {
        case RLMOperationAddMessage:
        {
            [self addMsg];
            break;
        }case RLMOperationUpdateMessage:
        {
            [self updateMsg];
            break;
        }case RLMOperationSearchMessage:
        {
            [self searchMsg];
            break;
        }case RLMOperationDeleteMessage:
        {
            [self deleteMsg];
            break;
        }case RLMOperationImage:
        {
            [self showImgs];
            break;
        }case RLMOperationArray:
        {
            [self showArrData];
            break;
        }
        default:
            break;
    }
}

- (void)addMsg
{
    [self showExist];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新增一条数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"输入姓名";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"输入性别";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"输入年龄";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *name = alert.textFields.firstObject;
        NSString *getName = FORMAT(@"%@",name.text);

        UITextField *sex = alert.textFields[1];
        NSString *getSex = FORMAT(@"%@",sex.text);

        UITextField *age = alert.textFields[2];
        NSString *getAge = FORMAT(@"%@",age.text);
        
        if (IsStrEmpty(getName)) {
            
            getName = @"未知";
        }
        if (IsStrEmpty(getSex)) {
            
            getSex = @"未知";
        }
        if (IsStrEmpty(getAge)) {
            
            getAge = @"0";
        }
        
        NSDictionary *mesDic = @{@"name":getName, @"sex":getSex, @"age":getAge};
        // 添加RLMObject类...
        [self doAddInfomation:mesDic];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma mark - 增...
- (void)doAddInfomation:(NSDictionary *)infoDic
{
    // 添加 RLMObject...
    RlmTextModel *model = [[RlmTextModel alloc] initWithDict:infoDic];
    BOOL isAdd = [RealmDataBaseService addRLMObject:model];
    
    if (isAdd) {
        
        NSLog(@"添加成功");
    } else {
        NSLog(@"添加失败");
    }
    
    
    [self showExist];

}
- (void)showExist
{
    // 显示已有数据...
    RealmDataBase *db = [RealmDataBase db];
    RLMResults *results = [RlmTextModel allObjectsInRealm:db];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (id objks in results) {
        
        [arr addObject:objks];
    }
    
    self.showV.itemArr = [NSMutableArray arrayWithArray:arr];
}
- (void)updateMsg
{
   [self showExist];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更新数据" message:@"【若数据为空则新增】" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"输入姓名";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"输入性别";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"输入年龄";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *name = alert.textFields.firstObject;
        NSString *getName = FORMAT(@"%@",name.text);
        
        UITextField *sex = alert.textFields[1];
        NSString *getSex = FORMAT(@"%@",sex.text);
        
        UITextField *age = alert.textFields[2];
        NSString *getAge = FORMAT(@"%@",age.text);
        
        if (IsStrEmpty(getName)) {
            
            getName = @"未知";
        }
        if (IsStrEmpty(getSex)) {
            
            getSex = @"未知";
        }
        if (IsStrEmpty(getAge)) {
            
            getAge = @"0";
        }
        
        NSDictionary *mesDic = @{@"name":getName, @"sex":getSex, @"age":getAge};
        // 添加RLMObject类...
        [self doUpdateInfomation:mesDic];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

}
#pragma mark - 修改数据...
- (void)doUpdateInfomation:(NSDictionary *)infoDic{
    
    // 搜索主键相同数据...
    NSString *predicate = FORMAT(@"name = '%@'", [infoDic objectForKey:@"name"]);
    RLMResults *results = [RealmDataBaseService queryClass:[RlmTextModel class] predicateCondition:predicate];
    if (results.count > 0) {
        
        // 已存在数据，执行更新...
        // add方法中，添加的方法已更改为addOrUpdate, 避免数据已存在时添加出错...
        RlmTextModel *model = results.firstObject;
        BOOL isUpdate = [RealmDataBaseService updateRLMObject:model conditionObj:infoDic];
        if (isUpdate) {
            
            NSLog(@"修改成功");
        } else {
            NSLog(@"修改失败");
        }
    } else {
        // 不存在数据，新增...
        RlmTextModel *model = [[RlmTextModel alloc] initWithDict:infoDic];
        BOOL isAdd = [RealmDataBaseService addRLMObject:model];
        if (isAdd) {
            
            NSLog(@"不存在当前数据，已新增");
        } else {
            NSLog(@"修改失败");
        }
    }
    [self showExist];
    
}
- (void)searchMsg
{
    // 根据主键查询/根据谓词查询...
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"查询数据" message:@"【当前为根据主键查找】" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输入姓名(姓名为primaryKey)";
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *name = alert.textFields.firstObject;
        NSString *getKey = FORMAT(@"%@", name.text);
        if (IsStrEmpty(getKey)) {
            
            getKey = @"未知";
        }
        getKey = [self deleteIllegalCharWith:getKey];// 去掉特殊字符...
        NSString *predicate = FORMAT(@"name = '%@'",getKey);
        
        RLMResults *results = [self searchBegin:predicate];
        if (results.count > 0) {
            
            // 已查询到数据...
            NSMutableArray *arr = [NSMutableArray array];
            for (id objks in results) {
                
                [arr addObject:objks];
            }
            
            self.showV.itemArr = [NSMutableArray arrayWithArray:arr];
        } else {
            
            // 未查询到数据...
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未查到相关数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

}
#pragma mark - 查询...
- (RLMResults *)searchBegin:(NSString *)predicate
{
    RLMResults *results = [RealmDataBaseService queryClass:[RlmTextModel class] predicateCondition:predicate];
    return results;
}

- (void)deleteMsg
{
    [self showExist];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"输入要删除成员的姓名";
    }];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"删除数据" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *name = alert.textFields.firstObject;
        NSString *getKey = FORMAT(@"%@", name.text);
        if (IsStrEmpty(getKey)) {
            
            getKey = @"未知";
        }
        getKey = [self deleteIllegalCharWith:getKey];// 去掉特殊字符...
        NSString *predicate = FORMAT(@"name = '%@'",getKey);
        
        // 查询要删除的数据...
        RLMResults *results = [self searchBegin:predicate];
        if (results.count > 0) {
            
            BOOL isDelete = [RealmDataBaseService deleteRLMObjects:results];
            if (isDelete) {
                
                NSLog(@"删除成功");
            } else {
                NSLog(@"删除失败");
            }
        }
        
        [self showExist];
    }];

    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];

}
#pragma mark - 图片保存...
- (void)opPic
{
    UIImage *imgL = [UIImage imageNamed:@"imgL"];
    UIImage *imgC = [UIImage imageNamed:@"imgC"];
    UIImage *imgR = [UIImage imageNamed:@"imgR"];
    // 压缩图片...
    NSData *imgDL= UIImageJPEGRepresentation(imgL, 0.5);
    NSData *imgDC= UIImageJPEGRepresentation(imgC, 0.5);
    NSData *imgDR= UIImageJPEGRepresentation(imgR, 0.5);

    RlmImgModel *modelL = [[RlmImgModel alloc] init];
    modelL.imgData = imgDL;
    modelL.opId = @"0";
    modelL.opType = @"img";
    [RealmDataBaseService addRLMObject:modelL];
    
    RlmImgModel *modelC = [[RlmImgModel alloc] init];
    modelC.imgData = imgDC;
    modelC.opId = @"1";
    modelC.opType = @"img";
    [RealmDataBaseService addRLMObject:modelC];
    
    RlmImgModel *modelR = [[RlmImgModel alloc] init];
    modelR.imgData = imgDR;
    modelR.opId = @"2";
    modelR.opType = @"img";
    [RealmDataBaseService addRLMObject:modelR];
    
}
- (void)showImgs
{
    RLMResults *results = [RealmDataBaseService queryClass:[RlmImgModel class] predicateCondition:FORMAT(@"opType = '%@'", @"img")];
    if (results.count > 0) {
        
        NSMutableArray *mulArr = [NSMutableArray array];
        for (id objks in results) {
            
            RlmImgModel *model = objks;
            UIImage *getImg = [UIImage imageWithData:model.imgData];
            [mulArr addObject:getImg];
        }
        
        self.showV.imgL.image = mulArr[0];
        self.showV.imgC.image = mulArr[1];
        self.showV.imgR.image = mulArr[2];

    }
}
#pragma mark - 数组保存...
- (void)opArray
{
    NSMutableArray *mulArr = [NSMutableArray array];
    UIImage *imgL = [UIImage imageNamed:@"imgL"];
    UIImage *imgC = [UIImage imageNamed:@"imgC"];
    UIImage *imgR = [UIImage imageNamed:@"imgR"];

    [mulArr addObject:imgL];
    [mulArr addObject:imgC];
    [mulArr addObject:imgR];

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mulArr];
    RlmArrayModel *model = [[RlmArrayModel alloc] init];
    model.opId = @"0";
    model.opType = @"arr";
    model.data = data;
    
    [RealmDataBaseService addRLMObject:model];
    
}
#pragma mark - 显示数组数据...
- (void)showArrData
{
    RLMResults *results = [RealmDataBaseService queryClass:[RlmArrayModel class] predicateCondition:FORMAT(@"opType = '%@'", @"arr")];
    if (results.count) {
        
        RlmArrayModel *model = results.firstObject;
        NSArray *getArr = [NSKeyedUnarchiver unarchiveObjectWithData:model.data];
        if (getArr.count > 0) {
            
            self.showV.imgL.image = getArr[0];
            self.showV.imgC.image = getArr[1];
            self.showV.imgR.image = getArr[2];
        }
    }
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSString *)deleteIllegalCharWith:(NSString *)inputStr
{
    NSError *error = nil;
    // 去掉符号,不包含空格...
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\p{P}~^<>]" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:inputStr options:0 range:NSMakeRange(0, [inputStr length]) withTemplate:@""];
    
    return modifiedString;
}


@end
