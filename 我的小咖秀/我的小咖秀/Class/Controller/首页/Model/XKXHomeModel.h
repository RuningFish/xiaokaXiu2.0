//
//  XKXHomeModel.h
//  我的小咖秀
//
//  Created by admin on 16/2/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKXHomeModel : NSObject
/** 图片名 */
@property (nonatomic,copy) NSString * picture;
/** 视频名称 */
@property (nonatomic,copy) NSString * name;
/** 视频地址 */
@property (nonatomic,copy) NSString * video;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)videoWithDictionary:(NSDictionary *)dict;
@end
