//
//  XKXSettingController.m
//  我的小咖秀
//
//  Created by admin on 16/2/18.
//  Copyright © 2016年 admin. All rights reserved.
//  设置

#import "XKXSettingController.h"
#import "MSPGroupModel.h"
#import "MSPArrowCell.h"
#import "XKXMessageController.h"
@interface XKXSettingController ()

@end

@implementation XKXSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.layer.contents = (id)[UIImage imageNamed:@"bg"].CGImage;
    
    self.tableView.scrollEnabled = NO;
    [self setUpGroup0];
    
    [self setUpGroup1];
    
     UIButton * footerView = [[UIButton alloc] init];
    footerView.frame = CGRectMake(0, 300, self.view.width, 35);
    [footerView setTitle:@"退出登录" forState:UIControlStateNormal];
    footerView.adjustsImageWhenHighlighted = NO;
    [footerView setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    footerView.titleLabel.font = [UIFont systemFontOfSize:13];
    [footerView setBackgroundImage:[UIImage imageNamed:@"head_top_bg"] forState:UIControlStateNormal];
    [footerView addTarget:self action:@selector(footViewClick) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = footerView;
    
}

- (void)footViewClick{
    
    UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:nil message:@"确定退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alertVc addAction:cancel];
    [alertVc addAction:sure];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)setUpGroup0{
    
    MSPArrowCell * cell0 = [MSPArrowCell cellWithTitle:@"消息设置" vcClass:[XKXMessageController class]];
    MSPArrowCell * cell1 = [MSPArrowCell cellWithTitle:@"邀请好友" vcClass:nil];
    
    MSPGroupModel * group = [[MSPGroupModel alloc] init];
    group.cellModel = @[cell0,cell1];
    
    [self.groupArr addObject:group];
    
}

- (void)setUpGroup1{
    
    MSPArrowCell * cell0 = [MSPArrowCell cellWithTitle:@"关于我们" vcClass:nil];
    MSPArrowCell * cell1 = [MSPArrowCell cellWithTitle:@"吐槽不爽" vcClass:nil];
    
    MSPGroupModel * group = [[MSPGroupModel alloc] init];
    group.cellModel = @[cell0,cell1];
    
    [self.groupArr addObject:group];
    
}

@end
