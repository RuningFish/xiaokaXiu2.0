//
//  XKXButton.m
//  我的小咖秀
//
//  Created by admin on 16/2/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "XKXButton.h"

@implementation XKXButton

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}
- (void)setHighlighted:(BOOL)highlighted{
    
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height - self.imageView.height;
    CGFloat x = 0;
    CGFloat y = self.imageView.height + 5;
    
    return CGRectMake(x, y, w, h);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat w = 90;
    CGFloat h = w;
    CGFloat x = (contentRect.size.width - w) * 0.5;
    CGFloat y = 0;
    
    return CGRectMake(x, y, w, h);
}
@end
