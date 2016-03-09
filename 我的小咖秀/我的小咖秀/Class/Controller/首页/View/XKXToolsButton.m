//
//  XKXToolsButton.m
//  我的小咖秀
//
//  Created by admin on 16/2/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "XKXToolsButton.h"

@implementation XKXToolsButton

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
       // 添加分隔条
        UIView * dividerLine = [[UIView alloc] init];
        self.dividerLine = dividerLine;
        [self addSubview:dividerLine];
        dividerLine.alpha = 0.5;
        dividerLine.backgroundColor = [UIColor lightGrayColor];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        self.adjustsImageWhenHighlighted = NO;
        [self.imageView sizeToFit];
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat w = 1;
    CGFloat margin = 10;
    CGFloat h = self.height - margin * 2;
    CGFloat x = self.width - w;
    CGFloat y = margin;
    self.dividerLine.frame = CGRectMake(x, y, w, h);
}

//- (CGRect)imageRectForContentRect:(CGRect)contentRect{
//    
//    return CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//}
@end
