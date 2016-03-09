//
//  XKXListView.m
//  我的小咖秀
//
//  Created by admin on 16/2/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "XKXListView.h"
#import "XKXListButton.h"
@interface XKXListView ()

@property (weak,nonatomic) UIImageView * arrowView;
@end
@implementation XKXListView

- (instancetype)init{
    
    if (self = [super init]) {
        
        UIImageView * arrow = [[UIImageView alloc] init];
        [self addSubview:arrow];
        arrow.image = [UIImage imageNamed:@"next_img"];
        //arrow.backgroundColor = [UIColor redColor];
        arrow.contentMode = UIViewContentModeCenter;
        self.arrowView = arrow;
        
        XKXListButton * button = [XKXListButton buttonWithType:UIButtonTypeCustom];
        self.button = button;
        //button.backgroundColor = XKXColor;
        [self addSubview:button];

        // 内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 图片右移
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        // 文字右移
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
        // 文字大小
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        // 文字颜色
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:KColor forState:UIControlStateSelected];
        button.adjustsImageWhenHighlighted = NO;
      
    }
    
    return self;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    
    CGFloat width = 15;
    CGFloat height = width;
    CGFloat x = self.frame.size.width - width;
    CGFloat y = (size.height - height) * 0.5;
    self.arrowView.frame = CGRectMake(x, y, width, height);
    
    self.button.frame = CGRectMake(0, 0, x,size.height);
}
@end
