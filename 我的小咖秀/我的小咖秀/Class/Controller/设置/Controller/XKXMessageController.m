//
//  XKXMessageController.m
//  我的小咖秀
//
//  Created by admin on 16/2/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "XKXMessageController.h"

@interface XKXMessageController ()

@end

@implementation XKXMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WTBarButtonItem * left = [WTBarButtonItem tabBarButtonWithTitle:nil andImage:@"back_btn_2_n"];
    [left addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    
    self.tableView.sectionFooterHeight = 0.0;
    self.tableView.sectionHeaderHeight = 10.0;
    self.view.layer.contents = (id)[UIImage imageNamed:@"bg"].CGImage;
    [self setUpGroup0];
}

- (void)leftButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setUpGroup0 {
    
      MSPCellModel * cell0 = [MSPSwitchCell cellWithTitle:@"新粉丝"];
      MSPCellModel * cell1 = [MSPSwitchCell cellWithTitle:@"评论"];
      MSPCellModel * cell2 = [MSPSwitchCell cellWithTitle:@"赞"];
      MSPCellModel * cell3 = [MSPSwitchCell cellWithTitle:@"新好友"];
      MSPCellModel * cell4 = [MSPSwitchCell cellWithTitle:@"新视频"];
    
    MSPGroupModel * group = [[MSPGroupModel alloc] init];
    group.header = @"收到哪些新消息提醒我";
    group.cellModel = @[cell0,cell1,cell2,cell3,cell4];
    
    [self.groupArr addObject:group];
}


@end
