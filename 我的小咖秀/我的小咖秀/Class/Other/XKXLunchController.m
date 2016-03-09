//
//  XKXLunchController.m
//  我的小咖秀
//
//  Created by admin on 16/2/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "XKXLunchController.h"
#import "XKXMainViewController.h"
#import "XKXNavigationController.h"
@interface XKXLunchController ()

@end

@implementation XKXLunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * lunchView = [[UIImageView alloc] init];
    lunchView.frame = self.view.bounds;
    lunchView.image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    [self.view addSubview:lunchView];
    
    
    // 2s后跳转到主控制器
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        
        XKXMainViewController * main = [[XKXMainViewController alloc] init];
        
        window.rootViewController = main;
        
    });


}

@end
