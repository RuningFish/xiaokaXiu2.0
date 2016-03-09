//
//  MSPShareButton.m
//  我的锁屏
//
//  Created by admin on 16/2/3.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MSPShareButton.h"

@implementation MSPShareButton
CGFloat margin = 5;

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat width = contentRect.size.width;
    CGFloat height = 13;
    CGFloat x = 0;
    CGFloat y = 57;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
 
    CGFloat width = contentRect.size.width - margin * 2;
    CGFloat height = 50;
    CGFloat x = margin;
    CGFloat y = margin;
    return CGRectMake(x, y, width, height);
    
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        // 字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       // self.titleLabel.backgroundColor = [UIColor redColor];
        self.imageView.contentMode = UIViewContentModeCenter;
        
    }
    return self;
}
@end
