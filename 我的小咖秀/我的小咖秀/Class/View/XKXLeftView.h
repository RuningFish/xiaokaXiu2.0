//
//  XKXLeftView.h
//  我的小咖秀
//
//  Created by admin on 16/2/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XKXLeftView;
@protocol XKXLeftViewDelegate <NSObject>

- (void)leftView:(XKXLeftView *)leftView didClickFormIndex:(NSInteger)formIndex toIndex:(NSInteger)toIndex;
@end
@interface XKXLeftView : UIView
+ (instancetype)leftView;

@property (weak,nonatomic) id<XKXLeftViewDelegate> delegate;
@end
