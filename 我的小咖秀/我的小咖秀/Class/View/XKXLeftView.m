//
//  XKXLeftView.m
//  我的小咖秀
//
//  Created by admin on 16/2/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#define KTitle @"title"
#define KIcon @"icon"
#define KSelImage @"selImage"
#define KDestVc @"destVc"

#import "XKXLeftView.h"
#import "XKXListView.h"
#import "XKXListButton.h"
@interface XKXLeftView ()
@property (weak,nonatomic) UIImageView * bgView;
@property (strong,nonatomic) UIButton * selectedButton;
@property (strong,nonatomic) NSMutableArray * data;
@end
@implementation XKXLeftView

+ (instancetype)leftView{
    
    return [[self alloc] init];
}

- (NSMutableArray *)data{
    
    if (_data == nil) {
        
        _data = [NSMutableArray array];
        
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"left.plist" ofType:nil];
        
        NSDictionary * dictArr = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        NSArray * tmp = dictArr[@"item"];
        
        for (NSDictionary * dict in tmp) {
            
            [_data addObject:dict];
        }
    }
    
    return _data;
}
- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        // 背景图片
        UIImageView * bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"left_n_menu_bg"];
        bgView.userInteractionEnabled = YES;
        self.bgView = bgView;
        [self addSubview:bgView];
        
}
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.bgView.frame = self.bounds;
    
    // listView
    CGFloat width = self.frame.size.width * 0.8;
    CGFloat height = 40;
    CGFloat x = self.frame.size.width * 0.1;
//    NSArray * str = @[@"首页",@"帮TA上热门",@"添加好友",@"声音库",@"本地作品",@"设置"];
//    NSArray * normalImage = @[@"hot_video_normal",@"help_hot_icon_n",@"add_friend",@"music_normal",@"local_video_normal",@"setting_normal"];
//    NSArray * selectedImage = @[@"hot_video_select",@"help_hot_icon_p",@"add_friend_select",@"music_select",@"local_video_select",@"setting_select"];
    
    for (int i = 0; i < self.data.count; i ++) {
        
        XKXListView *listView = [[XKXListView alloc] init];
        CGFloat y = (i * height) + 120;
        listView.frame = CGRectMake(x, y, width, height);
        
        NSDictionary * dict = self.data[i];
        // 设置文字
        [listView.button setTitle:dict[KTitle] forState:UIControlStateNormal];
        // 图片
        [listView.button setImage:[UIImage imageNamed:dict[KIcon]] forState:UIControlStateNormal];
        [listView.button setImage:[UIImage imageNamed:dict[KSelImage]] forState:UIControlStateSelected];
        
        listView.button.tag = i;
        // 添加事件
        [listView.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        [self.bgView addSubview:listView];
        
        if (i == 0) {
            
            [self buttonClick:listView.button];
        }
    }
    

}

- (void)buttonClick:(XKXListButton *)button{
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(leftView:didClickFormIndex:toIndex:)]) {
        
        [self.delegate leftView:self didClickFormIndex:self.selectedButton.tag toIndex:button.tag];
    }
    
    // 设置按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    NSDictionary * dict = self.data[button.tag];
    
    button.destVc = dict[KDestVc];
    
}
@end
