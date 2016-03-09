//
//  WTBarButtonItem.m
//  0107彩票
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 admin. All rights reserved.
//
#define KTitleFont [UIFont systemFontOfSize:15]
#import "WTBarButtonItem.h"

@implementation WTBarButtonItem

+ (WTBarButtonItem *)tabBarButtonWithTitle:(NSString *)title andImage:(NSString *)imageName{
    
    WTBarButtonItem * btn = [WTBarButtonItem buttonWithType:UIButtonTypeCustom];
    
    // 字体内容
    [btn setTitle:title forState:UIControlStateNormal];
    // 字体颜色
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  
    btn.titleLabel.font = KTitleFont;
    // 文字的内边距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    // 图片
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    
    CGSize titleSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    
    NSMutableDictionary * att = [NSMutableDictionary dictionary];
    
    // 字体大小
    att[NSFontAttributeName] = KTitleFont;
    // 字体的长度
   CGSize realSize = [title boundingRectWithSize:titleSize options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil].size;
    
    CGFloat imgWidth = [UIImage imageNamed:imageName].size.width;
    
    CGFloat btnRealWidth = imgWidth + btn.titleEdgeInsets.left + realSize.width;
    // btn的frame
    btn.frame = CGRectMake(0, 0, btnRealWidth, 25);
    // 高亮不改变图片
    btn.adjustsImageWhenHighlighted = NO;

    return btn;
}

@end
