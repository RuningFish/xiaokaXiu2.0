//
//  XKXMainViewController.m
//  我的小咖秀
//
//  Created by admin on 16/2/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#define KAnimateDuration 0.5
#import "XKXMainViewController.h"
#import "XKXLeftView.h"
#import "XKXNavigationController.h"
#import "XKXListButton.h"
#import "XKXHomeController.h"
#import "XKXHotViewController.h"
#import "XKXAddFriendController.h"
#import "XKXMusicController.h"
#import "XKXLocalVideoController.h"
#import "XKXSettingController.h"
@interface XKXMainViewController ()<XKXLeftViewDelegate>
/** 当前显示的导航控制器 */
@property (weak,nonatomic) XKXNavigationController * showingNavVc;
@end

@implementation XKXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    // 状态栏白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UIImageView * bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"bg"];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
    
    // 状态栏
    UIView * statusView = [[UIView alloc] init];
    statusView.frame = CGRectMake(0, 0, self.view.width, 20);
    statusView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:statusView];

    // 添加子控制器
    [self addAllChildControllers];
    
    // 设置左边视图
    XKXLeftView * leftView = [XKXLeftView leftView];
    leftView.delegate = self;
    CGSize size = self.view.frame.size;
    CGFloat width = size.width * 0.8;
    CGFloat height = size.height;
    leftView.frame = CGRectMake(0, 20, width, height);
    //leftView.backgroundColor = [UIColor redColor];
    [self.view addSubview:leftView];
   

}

/**********************创建子控制器*************************/
- (void)addAllChildControllers{
    
    XKXHomeController * home = [[XKXHomeController alloc] init];
    [self setupVc:home title:@"首页"];
    
    XKXHotViewController * hot = [[XKXHotViewController alloc] init];
    [self setupVc:hot title:@"帮TA上热门"];
    
    XKXAddFriendController * addFriend = [[XKXAddFriendController alloc] init];
    [self setupVc:addFriend title:@"添加好友"];
    
    XKXMusicController * music = [[XKXMusicController alloc] init];
    [self setupVc:music title:@"声音库"];

    XKXLocalVideoController * localVideo = [[XKXLocalVideoController alloc] init];
    [self setupVc:localVideo title:@"本地作品"];

    XKXSettingController * setting = [[XKXSettingController alloc] init];
    [self setupVc:setting title:@"设置"];

}

- (void)setupVc:(UIViewController *)vc title:(NSString *)title
{
    // 1.设置背景色
    vc.view.backgroundColor = XKXColor;
    vc.view.frame = CGRectMake(0, 64, self.view.width, self.view.height - 64);
    //NSLog(@"%@",NSStringFromCGRect(vc.view.frame));
    // 2.设置标题
    vc.navigationItem.title = title;
    
    // 3.设置左右按钮
    // 左边按钮
    WTBarButtonItem * left = [WTBarButtonItem tabBarButtonWithTitle:nil andImage:@"top_bar_menu_n"];
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    [left addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];

    // 4.包装一个导航控制器
    XKXNavigationController *nav = [[XKXNavigationController alloc] initWithRootViewController:vc];
   
   // [self.view addSubview:nav.view];
    [self addChildViewController:nav];
}

/********************导航栏左侧按钮点击事件**********************/
- (void)leftButtonClick {
    
    CGSize size = self.view.frame.size;
    
    // 1.设置动画
    [UIView animateWithDuration:KAnimateDuration animations:^{
        
        UIView * showingView = self.showingNavVc.view;
        
        showingView.transform = CGAffineTransformMakeTranslation(size.width * 0.8, 0);
    }];
    
    // 2.添加一个遮盖
    UIButton * cover = [UIButton buttonWithType:UIButtonTypeCustom];
    cover.frame = self.view.bounds;
    //self.cover = cover;
    //cover.backgroundColor = [UIColor redColor];
    [self.showingNavVc.view addSubview:cover];
    [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.发出通知
    // 用来在添加好友控制器中退出键盘
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MainControllerLeftButtonClick" object:nil];
}

/********************遮盖点击事件**********************/
- (void)coverClick:(UIButton *)cover {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.showingNavVc.view.transform = CGAffineTransformIdentity;
        // 移除遮盖
        [cover removeFromSuperview];
        
    }];
}
/********************左边视图的代理方法**********************/
- (void)leftView:(XKXLeftView *)leftView didClickFormIndex:(NSInteger)formIndex toIndex:(NSInteger)toIndex{
    
    // 移除旧控制器的view
    XKXNavigationController * oldNav = self.childViewControllers[formIndex];
    [oldNav.view removeFromSuperview];

    // 添加新控制器的view
    XKXNavigationController * newNav = self.childViewControllers[toIndex];
    newNav.view.transform = oldNav.view.transform;
    [self.view addSubview:newNav.view];
    
    [UIView animateWithDuration:KAnimateDuration animations:^{
        newNav.view.transform = CGAffineTransformIdentity;
    }];
    
    self.showingNavVc = newNav;
}
@end
