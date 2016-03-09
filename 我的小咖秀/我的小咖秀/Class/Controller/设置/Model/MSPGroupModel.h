//
//  WTGroup.h
//  0107彩票
//
//  Created by admin on 16/1/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSPGroupModel : NSObject
/** 头部标题 */
@property (nonatomic,copy) NSString * header;
/** 尾部标题 */
@property (nonatomic,copy) NSString * footer;
/** cell模型 */
@property (nonatomic,strong) NSArray * cellModel;

@end
