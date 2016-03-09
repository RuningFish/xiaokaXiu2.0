//
//  WTCellModel.h
//  0107彩票
//
//  Created by admin on 16/1/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 定义 block */
typedef void (^ WTCellModelOption)();
@interface MSPCellModel : NSObject
/** 图片 */
@property (nonatomic,copy) NSString * icon;
/** 文字 */
@property (nonatomic,copy) NSString * title;

@property (copy,nonatomic) WTCellModelOption option;
/** 要跳转的控制器 */
@property (assign,nonatomic) Class vcClass;

/** 有图片有文字*/
+ (instancetype)cellWithIcon:(NSString *)icon andTitle:(NSString *)title;
/** 只有文字 */
+ (instancetype)cellWithTitle:(NSString *)title;


+ (instancetype)cellWithTitle:(NSString *)title vcClass:(Class)vcClass;
@end
