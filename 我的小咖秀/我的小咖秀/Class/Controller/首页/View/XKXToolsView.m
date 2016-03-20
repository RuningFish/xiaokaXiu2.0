//
//  XKXToolsView.m
//  我的小咖秀
//
//  Created by admin on 16/2/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "XKXToolsView.h"
#import "XKXToolsButton.h"
#import "MSPShareButton.h"

@interface XKXToolsView ()<UMSocialUIDelegate>

@property (assign,nonatomic) CGFloat width;
@property (assign,nonatomic) CGFloat height;
@property (weak,nonatomic) UIView * line;
@property (weak,nonatomic) UIView * shareView;
@end
@implementation XKXToolsView

- (instancetype)initFrame:(CGRect)frame andArray:(NSArray<NSString *> *)array{
    
    if (self = [super initWithFrame:frame]) {
        
        self.width = frame.size.width;
        self.height = frame.size.height;
        self.backgroundColor = [UIColor clearColor];
        // 1.创建里面的按钮
        // 按钮的个数
        NSInteger count = array.count;
       NSArray * imageArr = @[@"btn_love_p",@"btn_share",@"btn_right_more_n"];

        for(int i = 0; i < count; i++){
            
            XKXToolsButton * button = [[XKXToolsButton alloc] init];
            
            button.tag = i;
            // 设置文字
            [button setTitle:array[i] forState:UIControlStateNormal];
            // 字体大小
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            // 字体颜色
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            // 设置图片
            [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
            // button.frame = CGRectMake(i * width, 0, width, height);
            [self addSubview:button];
            
            if (i == count - 1) {// 隐藏最后一个按钮的分隔条
                
                button.dividerLine.hidden = YES;
            }
            // 添加事件
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            //button.backgroundColor = XKXColor;
        }
        
    }
    
    return self;

}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 按钮的宽度
    CGFloat width = self.width / self.subviews.count;
    CGFloat height = self.height;
    
    for (int i = 0; i < self.subviews.count; i++) {
        
        UIButton * button = self.subviews[i];
        button.frame = CGRectMake(i * width, 0, width, height);
        
    }
    
}

- (void)buttonClick:(UIButton *)button{
    
    if (button.tag == 0) {// 第一个按钮
        
        NSString * currentStr = button.currentTitle;
        
        int loveCount = [currentStr intValue];
        if ([button.currentImage isEqual:[UIImage imageNamed:@"btn_love_p"]]) {
            
            [button setImage:[UIImage imageNamed:@"btn_love_n"] forState:UIControlStateNormal];
            [button setTitle:[NSString stringWithFormat:@"%d",loveCount + 1] forState:UIControlStateNormal];
            
        }else{
            
            [button setImage:[UIImage imageNamed:@"btn_love_p"] forState:UIControlStateNormal];
            [button setTitle:[NSString stringWithFormat:@"%d",loveCount - 1] forState:UIControlStateNormal];
        }
    }else if (button.tag == 1){// 分享按钮
        // 调用block
        self.option();
       
    }else{// 更多按钮
        
        UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction * jubao = [UIAlertAction actionWithTitle:@"举报视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertVc addAction:jubao];
        [alertVc addAction:cancel];
        
        if ([self.delegate respondsToSelector:@selector(toolView:witnController:)]) {
            
            [self.delegate toolView:self witnController:alertVc];
        }
       // [self.superclass presentViewController:alertVc animated:YES completion:nil];
    }
}

//- (void)shareTo{
//    
//    /*********************创建遮盖*************************/
//    UIButton * cover = [UIButton buttonWithType:UIButtonTypeCustom];
//    cover.frame = CGRectMake(0, 0, self.superview.width, self.superview.height);
//    // 背景色
//    cover.backgroundColor = [UIColor blackColor];
//    cover.alpha = 0.0;
//    [self.superview addSubview:cover];
//    // 添加点击事件
//    [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchDown];
//    
//    /*********************创建分享框*************************/
//    // 1.创建分享框
//    UIView * shareView = [[UIView alloc] init];
//    CGFloat shareWidth = self.superview.width;
//    CGFloat shareHeight = 200;
//    CGFloat shareY = self.superview.height;
//    self.shareView = shareView;
//    shareView.backgroundColor = [UIColor blackColor];
//    //shareView.alpha = 0.5;
//    shareView.frame = CGRectMake(0, shareY, shareWidth, shareHeight);
//    [self.superview addSubview:shareView];
//    
//    // 动画效果
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        cover.alpha = 0.5;
//        self.shareView.transform = CGAffineTransformMakeTranslation(0, -shareHeight);
//        
//    }];
//    
//    // 2.创建分享label
//    UILabel * shareLabel = [[UILabel alloc] init];
//    shareLabel.text = @"分享到";
//    shareLabel.textAlignment = NSTextAlignmentCenter;
//    shareLabel.font = [UIFont systemFontOfSize:13];
//    shareLabel.textColor = [UIColor whiteColor];
//    shareLabel.frame = CGRectMake(0, 0, shareWidth, 30);
//    [shareView addSubview:shareLabel];
//    
//    // 3.创建分享内容
//    
//    CGFloat margin = 10;
//    UIView * shareButtonView = [[UIView alloc] init];
//    CGFloat buttonViewWidth = shareWidth - margin * 2;
//    CGFloat buttonViewHeight = shareHeight - shareLabel.height - margin * 2;
//    CGFloat buttonViewX = margin;
//    CGFloat buttonViewY = shareLabel.height + margin;
//    //shareButtonView.backgroundColor = [UIColor yellowColor];
//    shareButtonView.frame = CGRectMake(buttonViewX, buttonViewY, buttonViewWidth, buttonViewHeight);
//    [shareView addSubview:shareButtonView];
//    // 列数
//    int colCount = 3;
//    // 行数
//    int rowCount = 2;
//    // 分享内容的个数
//    int count = colCount * rowCount;
//    
//    // 按钮的宽度
//    CGFloat buttonWidth = (buttonViewWidth - (colCount - 1) * margin - margin * 2) / colCount;
//    // 按钮的高度
//    CGFloat buttonHeight = (buttonViewHeight - margin ) / rowCount;
//    
//    NSArray * str = @[@"微博",@"朋友圈",@"微信",@"QQ",@"QQ空间",@"复制链接"];
//    NSArray * img = @[@"auth_weibo_img",
//                      @"filter_img_btn",
//                      @"auth_weixin_img",
//                      @"auth_qq_img",
//                      @"qq_zone_img_btn",
//                      @"copy_url",
//                     ];
//    for (int i = 0; i < count; i ++) {
//        
//        MSPShareButton * shareButton = [[MSPShareButton alloc] init];
//        [shareButtonView addSubview:shareButton];
//        // 行号
//        int row = i / colCount;
//        // 列号
//        int col = i % colCount;
//        CGFloat buttonX = margin + (buttonWidth + margin) * col;
//        CGFloat buttonY = buttonHeight * row;
//        //shareButton.backgroundColor = MSPColor;
//        shareButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
//        //MSPLog(@"%d-------%@",i,NSStringFromCGRect(shareButton.frame));
//        // 设置文字
//        [shareButton setTitle:str[i] forState:UIControlStateNormal];
//        // 设置图片
//        NSString * imgStr = img[i];
//        if (imgStr.length > 0) {
//            
//            [shareButton setImage:[UIImage imageNamed:img[i]] forState:UIControlStateNormal];
//            
//        }
//        
//    }
//
//}
//
//- (void)coverClick:(UIButton *)cover{
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        cover.alpha = 0.0;
//        self.shareView.transform = CGAffineTransformIdentity;
//        
//    } completion:^(BOOL finished) {
//        
//        [cover removeFromSuperview];
//        [self.shareView removeFromSuperview];
//    }];
//}
@end
