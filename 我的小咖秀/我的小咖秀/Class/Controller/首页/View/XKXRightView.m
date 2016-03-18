//
//  XKXRightView.m
//  我的小咖秀
//
//  Created by admin on 16/3/18.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "XKXRightView.h"
#import "XKXButton.h"
#import <Pop.h>
@interface XKXRightView ()
// 装按钮的数组
@property (strong,nonatomic) NSMutableArray * btnArr;

@end
@implementation XKXRightView

- (NSMutableArray *)btnArr{
    
    if (_btnArr == nil) {
        
        _btnArr = [NSMutableArray array];
    }
    
    return _btnArr;
}
+ (instancetype)rightView{
    
    return [[self alloc] init];
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        // 按钮
        NSArray * str = @[@"对嘴",@"合演",@"原创"];
        NSArray * img = @[@"icon_bg_recorder",@"icon_bg_together",@"icon_bg_original"];
        
        long count = str.count;
       
        CGFloat w = 115;
        CGFloat h = w;
        CGFloat x = (self.frame.size.width - w) * 0.5;
        CGFloat margin = 30;
        CGFloat top = (self.frame.size.height - count * h - (count - 1) * margin) * 0.5;
        for (int i = 0; i < count; i ++) {
            
            XKXButton * button = [[XKXButton alloc] init];
            // 文字
            [button setTitle:str[i] forState:UIControlStateNormal];
            // 图片
            [button setImage:[UIImage imageNamed:img[i]] forState:UIControlStateNormal];
    
            int col = i % count;
            CGFloat y = (col * (h + margin)) + top;
            button.frame = CGRectMake(x, y, w, h);
            button.x = x;
            button.y = y - KScreenHeight * 0.5;
            button.width = w;
            button.height = w;

            [self.btnArr addObject:button];
            [self addSubview:button];
            
        }
        // 打开用户交互
        self.userInteractionEnabled = YES;
        // 添加手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClick)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)bgViewClick{
    
        [self.btnArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(XKXButton * button, NSUInteger idx, BOOL * _Nonnull stop) {
            
            POPSpringAnimation * anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
            anim.toValue = [NSValue valueWithCGPoint:(CGPointMake(button.center.x + KScreenWidth * 0.5 , button.center.y - KScreenHeight))];
            //anim.toValue =  [NSValue valueWithCGRect:button.frame];
            anim.springBounciness = 7;
            anim.springSpeed = 2;
            anim.beginTime = CACurrentMediaTime() + idx * 0.035;
            [button pop_addAnimation:anim forKey:nil];
            
        }];

        
        [UIView animateWithDuration:0.5 animations:^{
             [self removeFromSuperview];
        }];
    
}
- (void)didMoveToSuperview{
    [super didMoveToSuperview];
  
    [self.btnArr enumerateObjectsUsingBlock:^(XKXButton * button, NSUInteger idx, BOOL * _Nonnull stop) {
        
        POPSpringAnimation * anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        anim.toValue = [NSValue valueWithCGPoint:(CGPointMake(button.center.x + KScreenWidth * 0.5 , button.center.y + KScreenHeight))];
        anim.springBounciness = 5;
        anim.springSpeed = 3;
        anim.beginTime = CACurrentMediaTime() + idx * 0.025;
        [button pop_addAnimation:anim forKey:nil];
    }];
   
}
@end
