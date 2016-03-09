//
//  WTBarButtonItem.h
//  0107彩票
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 admin. All rights reserved.
//  自定义UIBarButtonItem

#import <UIKit/UIKit.h>

@interface WTBarButtonItem : UIButton

+ (WTBarButtonItem *)tabBarButtonWithTitle:(NSString *)title andImage:(NSString *)imageName;
@end
