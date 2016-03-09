//
//  XKXAddFriendButton.m
//  我的小咖秀
//
//  Created by admin on 16/2/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "XKXAddFriendCell.h"

@interface XKXAddFriendCell ()
/** 右侧箭头 */
@property (weak,nonatomic) UIImageView * rightImageView;
/** 底部分割线 */
@property (weak,nonatomic) UIView * bottomLine;
@end
@implementation XKXAddFriendCell

- (instancetype)init{
    
    if (self = [super init]) {
        
        // 背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"head_top_bg"] forState:UIControlStateNormal];
        // 箭头
        UIImageView * rightImageView = [[UIImageView alloc] init];
        self.rightImageView = rightImageView;
        [self addSubview:rightImageView];
        rightImageView.image = [UIImage imageNamed:@"next_img"];
        rightImageView.contentMode = UIViewContentModeCenter;
        //rightImageView.backgroundColor = [UIColor redColor];
        
        // 底部分割线
        UIView * bottomLine = [[UIView alloc] init];
        self.bottomLine = bottomLine;
        [self addSubview:bottomLine];
        bottomLine.backgroundColor = [UIColor lightGrayColor];
        
        
        // 内容左对齐
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat margin = 10;
    // 右侧箭头
    CGFloat arrowWidth = 20;
    CGFloat arrowX = self.width - arrowWidth - margin * 0.5;
    CGFloat arrowY = (self.height - arrowWidth) * 0.5;
    self.rightImageView.frame = CGRectMake(arrowX, arrowY, arrowWidth, arrowWidth);
    
    // 底部条
    CGFloat bottomWidth = self.width - margin * 2;
    CGFloat bottomHeight = 1;
    CGFloat bottomX = margin;
    CGFloat bottomY = self.height - bottomHeight;
    self.bottomLine.frame = CGRectMake(bottomX, bottomY, bottomWidth, bottomHeight);
}

- (void)setHighlighted:(BOOL)highlighted{
    
    
}

- (void)setIsShowBottomLine:(BOOL)isShowBottomLine{

    self.bottomLine.hidden = isShowBottomLine;
}
@end
