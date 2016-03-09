//
//  WTSelectedView.h
//  我的锁屏
//
//  Created by admin on 16/2/5.
//  Copyright © 2016年 admin. All rights reserved.
//  可以滚动选择的view

#import <UIKit/UIKit.h>

@interface WTSelectedView : UIView

/** 选择按钮的图片 */
@property (strong,nonatomic) NSArray * imageArr;
/** 选中的滑动条颜色 */
@property (strong,nonatomic) UIColor * selectedColor;
/** 通过传入的frame创建一个选择视图 */
- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray<NSString *> *)strArray;

@end
