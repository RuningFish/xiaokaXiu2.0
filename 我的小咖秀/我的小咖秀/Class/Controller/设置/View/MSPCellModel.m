//
//  WTCellModel.m
//  0107彩票
//
//  Created by admin on 16/1/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MSPCellModel.h"

@implementation MSPCellModel
+ (instancetype)cellWithIcon:(NSString *)icon andTitle:(NSString *)title
{
    MSPCellModel * cellModel = [[self alloc] init];
    if (icon.length > 0) {
        
         cellModel.icon = icon;
    }
    cellModel.title = title;
    
    return cellModel;
}

+ (instancetype)cellWithTitle:(NSString *)title{
    
    return [self cellWithIcon:nil andTitle:title];
}



+ (instancetype)cellWithTitle:(NSString *)title vcClass:(Class)vcClass{
    
    MSPCellModel * cell = [[self alloc] init];
    
    cell.title = title;
    cell.vcClass = vcClass;
    
    return cell;
}
@end
