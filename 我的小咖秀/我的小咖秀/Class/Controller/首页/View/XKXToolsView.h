//
//  XKXToolsView.h
//  我的小咖秀
//
//  Created by admin on 16/2/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XKXToolsView;
@protocol XKXToolsViewDelegate <NSObject>
@optional
- (void)toolView:(XKXToolsView *)toolView witnController:(UIViewController *)controller;

@end
// 定义一个block
typedef void (^toolsViewBlock) ();
@interface XKXToolsView : UIView

- (instancetype)initFrame:(CGRect)frame andArray:(NSArray<NSString *> *)array;
/** 按钮normal图片 */
//@property (strong,nonatomic) NSArray * imageArr;
/** 按钮selected图片 */
@property (strong,nonatomic) NSArray * selImageArr;

@property (assign,nonatomic) id<XKXToolsViewDelegate> delegate;
// block属性
@property (nonatomic,copy) toolsViewBlock option;
@end
