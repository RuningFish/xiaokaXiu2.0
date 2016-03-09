//
//  XKXHotViewController.m
//  我的小咖秀
//
//  Created by admin on 16/2/18.
//  Copyright © 2016年 admin. All rights reserved.
//  帮TA上热门

#import "XKXHotViewController.h"

@interface XKXHotViewController ()

@end

@implementation XKXHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // btn_right_more_n
    // 右边按钮
    WTBarButtonItem * right = [WTBarButtonItem tabBarButtonWithTitle:nil andImage:@"btn_right_more_n"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    [right addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];

}

- (void)rightButtonClick {

    UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * change = [UIAlertAction actionWithTitle:@"换一批" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * jubao = [UIAlertAction actionWithTitle:@"举报视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:change];
    [alertVc addAction:jubao];
    [alertVc addAction:cancel];

    
    [self presentViewController:alertVc animated:YES completion:nil];
}

@end
