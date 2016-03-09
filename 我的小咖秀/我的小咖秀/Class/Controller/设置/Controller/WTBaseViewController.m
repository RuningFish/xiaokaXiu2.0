//
//  WTBaseViewController.m
//  0107彩票
//
//  Created by admin on 16/1/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WTBaseViewController.h"

@interface WTBaseViewController ()

@end

@implementation WTBaseViewController

- (instancetype)init
{
    if (self == [super initWithStyle:UITableViewStyleGrouped]) {
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self == [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    
    return self;
}
- (NSMutableArray *)groupArr
{
    if (_groupArr == nil) {
        
        _groupArr = [NSMutableArray array];
    }
    
    return _groupArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.bounces = NO;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _groupArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    MSPGroupModel * group = self.groupArr[section];
    
    return group.cellModel.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建cell
    MSPMoreCell * cell = [MSPMoreCell cellWithTableView:tableView];
    // 给cell传递模型
    
    MSPGroupModel * group = self.groupArr[indexPath.section];
    
    cell.model = group.cellModel[indexPath.row];
    // 返回cell
    return cell;
}

// 跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MSPGroupModel * group = self.groupArr[indexPath.section];
    
    MSPCellModel * model = group.cellModel[indexPath.row];
    
    if (model.option) {
        
        model.option();
        
    }else if ([model isKindOfClass:[MSPArrowCell class]]) {
        
        MSPArrowCell * cell = (MSPArrowCell *)model;
        
        if (cell.vcClass == nil) return;
        
        UIViewController * vc = [[cell.vcClass alloc]  init];
        
        vc.title = cell.title;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([model isKindOfClass:[MSPCellModel class]]){
        
        MSPCellModel * cell = (MSPArrowCell *)model;
        
        if (cell.vcClass == nil) return;
        
        UIViewController * vc = [[cell.vcClass alloc]  init];
        
        vc.title = cell.title;
        
        [self presentViewController:vc animated:YES completion:nil];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    MSPGroupModel * group = self.groupArr[section];
    
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    MSPGroupModel * group = self.groupArr[section];
    
    return group.footer;
}
@end

