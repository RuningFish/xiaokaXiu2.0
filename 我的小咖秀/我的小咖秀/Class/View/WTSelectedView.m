//
//  WTSelectedView.m
//  我的锁屏
//
//  Created by admin on 16/2/5.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WTSelectedView.h"
#import "XKXListButton.h"
@interface WTSelectedView ()
/** 底部选择条 */
@property (weak,nonatomic) UIView * selectedLine;
/** 选中的按钮 */
@property (weak,nonatomic) UIButton * selectedButton;
/** 宽度 */
@property (assign,nonatomic) CGFloat width;
/** 高度 */
@property (assign,nonatomic) CGFloat height;
/** 下标 */
@property (assign,nonatomic) NSInteger index;
/** 存放按钮的数组 */
@property (strong,nonatomic) NSMutableArray * buttonArray;
@end
@implementation WTSelectedView

- (NSMutableArray *)buttonArray{
    
    if (_buttonArray == nil) {
        
        _buttonArray = [NSMutableArray array];
    }
    
    return _buttonArray;
}

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray<NSString *> *)strArray {
    
    //NSLog(@"%f----%f",self.width,self.height);
//    WTSelectedView * selectedView = [[WTSelectedView alloc] initWithFrame:frame];
//    selectedView.frame = frame;

    
    if (self = [super initWithFrame:frame]) {
        
        self.width = frame.size.width;
        self.height = frame.size.height;
        
        // 1.底部滑动条
        UIView * selectedline = [[UIView alloc] init];
        selectedline.backgroundColor = KColor;
        self.selectedLine = selectedline;
        [self addSubview:selectedline];
        
        
        // 2.创建里面的按钮
        // 按钮的个数
        NSInteger count = strArray.count;
        
        for(int i = 0; i < count; i++){
            
            XKXListButton * button = [XKXListButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            // 设置文字
            [button setTitle:strArray[i] forState:UIControlStateNormal];
            // 字体大小
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            // 字体颜色
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            // 选中颜色
            [button setTitleColor:KColor forState:UIControlStateSelected];
            // 设置图片
            [button setImage:self.imageArr[i] forState:UIControlStateNormal];
            // button.frame = CGRectMake(i * width, 0, width, height);
            [self addSubview:button];
            [self.buttonArray addObject:button];
            // 添加事件
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 1) {
                
                [self buttonClick:button];
            }
        }
        
        //NSLog(@"buttonArray-----%ld",self.buttonArray.count);
        
    }
    
    return self;
  
    
//    // 底部条的高度
//    CGFloat selectedLineH = 2;
//    // 按钮的宽度
//    CGFloat width = self.width / strArray.count;
//    // 按钮的高度
//    CGFloat height = self.height - selectedLineH;
//    
//    CGFloat margin = 10;
//    
//    // 底部条的宽度
//    CGFloat selectedLineWidth = width - margin;
//    CGFloat x = margin * 0.5 + width * self.index;
//    CGFloat y = height;
//    // 底部条的位置
//    self.selectedLine.frame = CGRectMake(x, y, selectedLineWidth, selectedLineH);
    
   
//    // 按钮的个数
//    NSInteger count = strArray.count;
//    self.buttonCountArray = strArray;
//    // 创建里面的按钮
//    for(int i = 0; i < count; i++){
//        
//        XKXListButton * button = [XKXListButton buttonWithType:UIButtonTypeCustom];
//    
//        button.tag = i;
//        // 设置文字
//        [button setTitle:strArray[i] forState:UIControlStateNormal];
//        // 字体大小
//        button.titleLabel.font = [UIFont systemFontOfSize:13];
//        // 字体颜色
//        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        // 选中颜色
//        [button setTitleColor:KColor forState:UIControlStateSelected];
//        
//       // button.frame = CGRectMake(i * width, 0, width, height);
//
//        [selectedView addSubview:button];
//        [self.buttonArray addObject:button];
//        
//        //NSLog(@"%ld",self.buttonArray.count);
//        // 添加事件
//        [button addTarget:self action:@selector(buttonClick: ) forControlEvents:UIControlEventTouchUpInside];
//        
//        if (i == 0) {
//
//            [self buttonClick:button];
//        }
//    }
//    
//     NSLog(@"%ld",self.buttonArray.count);
//
//    return selectedView;
}

- (void)buttonClick:(UIButton *)button{
    
    //
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    self.index = button.tag;
    
    // 移动的距离
    CGFloat tranformX = 0;
    
    if (button.tag == 1) {
        
        tranformX = 0;
    }else if (button.tag == 2){
        
        tranformX = button.width;
    }else{
        
        tranformX = - button.width;
    }
    
    // 移动底部条
    [UIView animateWithDuration:0.2 animations:^{
        
        self.selectedLine.transform = CGAffineTransformMakeTranslation(tranformX, 0);
    }];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
      //NSLog(@"%ld",self.buttonArray.count);
    // 底部条的高度
    CGFloat selectedLineH = 2;
    // 按钮的宽度
    CGFloat width = self.width / self.buttonArray.count;
    // 按钮的高度
    CGFloat height = self.height - selectedLineH;
    
    CGFloat margin = 10;
 
    // 底部条的宽度
    CGFloat selectedLineWidth = width - margin;
    CGFloat x = margin * 0.5 + width * self.index;
    CGFloat y = height;
    // 底部条的位置
    self.selectedLine.frame = CGRectMake(x, y, selectedLineWidth, selectedLineH);
    
    long count = self.buttonArray.count;
    for (int i = 0; i < count; i ++) {
        
        XKXListButton * button = self.buttonArray[i];
        
        button.tag = i;
        // 按钮的位置
        button.frame = CGRectMake(i * width, 0, width, height);
        
       // NSLog(@"%@",NSStringFromCGRect(button.frame));
    }
    

}
@end
