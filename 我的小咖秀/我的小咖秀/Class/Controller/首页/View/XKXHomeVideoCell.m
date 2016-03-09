//
//  XKXHomeVideoCell.m
//  我的小咖秀
//
//  Created by admin on 16/2/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "XKXHomeVideoCell.h"
#import "XKXHomeModel.h"
@interface XKXHomeVideoCell ()
/** 图片 */
@property (weak,nonatomic) UIImageView * imageView;
/** 描述 */
@property (weak,nonatomic) UILabel * name;

@end
@implementation XKXHomeVideoCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
       // 创建子控件
        UIImageView * imageView = [[UIImageView alloc] init];
        self.imageView = imageView;
        imageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imageView];
        
        UILabel * name = [[UILabel alloc] init];
        self.name = name;
        //name.backgroundColor = [UIColor greenColor];
        name.font = [UIFont systemFontOfSize:13];
        name.textColor = [UIColor whiteColor];
        name.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:name];
    }
    
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 图片的位置
    self.imageView.frame = CGRectMake(0, 0, self.width, self.height);
    
    // 文字的位置
    CGFloat w = self.width;
    CGFloat h = 20;
    CGFloat y = self.height - h - 5;
    self.name.frame = CGRectMake(0, y, w, h);
}

- (void)setVideo:(XKXHomeModel *)video{
    
    _video = video;
    
    self.imageView.image = [UIImage imageNamed:video.picture];
    self.name.text = video.name;
}
@end
