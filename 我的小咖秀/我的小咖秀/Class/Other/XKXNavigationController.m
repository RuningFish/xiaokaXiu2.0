//
//  XKXNavigationController.m
//  我的小咖秀
//
//  Created by admin on 16/2/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "XKXNavigationController.h"

@interface XKXNavigationController ()

@end

@implementation XKXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)initialize{
    
    UINavigationBar * navBar = [UINavigationBar appearance];

    [navBar setBackgroundImage:[UIImage imageNamed:@"head_top_bg"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:attrs];
}

@end
