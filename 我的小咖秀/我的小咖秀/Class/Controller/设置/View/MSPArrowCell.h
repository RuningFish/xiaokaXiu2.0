//
//  WTArrowCell.h
//  0107彩票
//
//  Created by admin on 16/1/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MSPCellModel.h"

@interface MSPArrowCell : MSPCellModel


+ (instancetype)cellWithIcon:(NSString *)icon andTitle:(NSString *)title vcClass:(Class)vcClass;
+ (instancetype)cellWithTitle:(NSString *)title vcClass:(Class)vcClass;
@end
