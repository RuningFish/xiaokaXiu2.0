//
//  XKXAddFriendController.m
//  我的小咖秀
//
//  Created by admin on 16/2/18.
//  Copyright © 2016年 admin. All rights reserved.
//  添加好友

#import "XKXAddFriendController.h"
#import "XKXAddFriendCell.h"
@interface XKXAddFriendController ()<UITextFieldDelegate>
/** 搜索框 */
@property (weak,nonatomic) UITextField * searchField;
/** 取消按钮 */
@property (weak,nonatomic) UIButton * cancelButton;
/**  搜索框的frame */
@property (assign,nonatomic) CGRect searchFrame;

@property (weak,nonatomic) UIView * cellView;
@end

@implementation XKXAddFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景图片
    self.view.layer.contents = (id)[UIImage imageNamed:@"bg"].CGImage;
    // 1.设置搜索框的背景图片
    UIImageView * bgInageView = [[UIImageView alloc] init];
    [self.view addSubview:bgInageView];
    bgInageView.userInteractionEnabled = YES;
    bgInageView.width = self.view.width;
    bgInageView.height = 50;
    bgInageView.x = 0;
    bgInageView.y = 64;
    bgInageView.backgroundColor = XKXColor;

    // 2.创建搜索框
    UITextField * searchField = [[UITextField alloc] init];
    searchField.delegate = self;
    self.searchField = searchField;
    [bgInageView addSubview:searchField];
    CGFloat margin = 10;
    CGFloat w = bgInageView.width - margin * 2;
    CGFloat h = bgInageView.height - margin * 2;
    searchField.frame = CGRectMake(margin, margin, w, h);
    self.searchFrame = searchField.frame;
    searchField.backgroundColor = [UIColor whiteColor];
    searchField.layer.cornerRadius = 15;
    // 占位文字
    searchField.placeholder = @"搜索小咖秀用户(昵称)";
    // 字体大小
    searchField.font = [UIFont systemFontOfSize:13];
    // 左侧搜索图片
    UIImageView * searchImage = [[UIImageView alloc] init];
    //searchImage.backgroundColor = [UIColor redColor];
    searchImage.frame = CGRectMake(15, 0, 30, searchField.height);
    searchImage.image = [UIImage imageNamed:@"search_img"];
    searchImage.contentMode = UIViewContentModeCenter;
    searchField.leftView = searchImage;
    searchField.leftViewMode = UITextFieldViewModeAlways;
    //NSLog(@"%@",NSStringFromCGRect(searchField.frame));
    
    // 3.取消按钮
    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton = cancelButton;
    cancelButton.hidden = YES;
    [bgInageView addSubview:cancelButton];
    CGFloat cancelWidth = 40;
    CGFloat cancelHeight = searchField.height;
    CGFloat cancelX = self.view.width - margin - cancelWidth;
    CGFloat cancelY = margin;
    cancelButton.frame = CGRectMake(cancelX, cancelY, cancelWidth, cancelHeight);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:13];
    //cancelButton.backgroundColor = [UIColor greenColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 用户排行
    UIView * cellView = [[UIView alloc] init];
    self.cellView = cellView;
    [self.view addSubview:cellView];
    CGFloat maxY = CGRectGetMaxY(bgInageView.frame);
    CGFloat cellHeight = 44;
    int count = 5;
    
    NSArray * str = @[@"用户排行",@"新浪微博",@"用户排行",@"新浪微博",@"用户排行"];
    NSArray * img = @[@"user_top",@"sina_weibo",@"user_top",@"sina_weibo",@"user_top"];
    for (int i = 0; i < count; i ++) {
        XKXAddFriendCell * cell = [[XKXAddFriendCell alloc] init];
        
        CGFloat cellY = i * cellHeight;
        cell.frame = CGRectMake(0, cellY, self.view.width, cellHeight);
     
        // 文字
        [cell setTitle:str[i] forState:UIControlStateNormal];
        // 图片
        [cell setImage:[UIImage imageNamed:img[i]] forState:UIControlStateNormal];
        [cellView addSubview:cell];
        
        if (i == count - 1 ) {
            
            cell.isShowBottomLine = YES;
        }
        
        cellView.frame = CGRectMake(0, maxY, self.view.width, CGRectGetMaxY(cell.frame));
        
    }
   // NSLog(@"%@",NSStringFromCGRect(cellView.frame));
    
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitKeyBoard) name:@"MainControllerLeftButtonClick" object:nil];
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)exitKeyBoard{
    
    [self cancelButtonClick];
}
/*****************开始编辑******************/
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.searchField.frame = CGRectMake(self.searchFrame.origin.x, self.searchFrame.origin.y, self.searchFrame.size.width - 45 , self.searchFrame.size.height);
    // 显示取消按钮
    self.cancelButton.hidden = NO;
    // 隐藏cellView
    self.cellView.hidden = YES;
}

- (void)cancelButtonClick {
    
    // 1.将搜索框的宽度变回到圆脸的宽度
    self.searchField.frame = self.searchFrame;
    
    // 2.隐藏取消按钮
    self.cancelButton.hidden = YES;
    
    // 3.退出键盘
    [self.view endEditing:YES];
    
    // 4.显示cellView
    self.cellView.hidden = NO;
    
}
@end
