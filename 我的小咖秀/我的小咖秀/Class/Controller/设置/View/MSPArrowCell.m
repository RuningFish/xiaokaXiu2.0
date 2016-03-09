//
//  WTArrowCell.m
//  0107彩票
//
//  Created by admin on 16/1/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MSPArrowCell.h"

@implementation MSPArrowCell

+ (instancetype)cellWithIcon:(NSString *)icon andTitle:(NSString *)title vcClass:(Class)vcClass{
    
    MSPArrowCell * cell = [[self alloc] init];
    cell.icon = icon;
    cell.title = title;
    cell.vcClass = vcClass;
    
    return cell;
}

+ (instancetype)cellWithTitle:(NSString *)title vcClass:(Class)vcClass{
    
    return [self cellWithIcon:nil andTitle:title vcClass:vcClass];
}
@end
