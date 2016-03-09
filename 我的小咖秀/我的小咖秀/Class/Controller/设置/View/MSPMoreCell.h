//
//  MSPMoreCell.h
//  我的锁屏
//
//  Created by admin on 16/1/30.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MSPCellModel;
@interface MSPMoreCell : UITableViewCell
/** cell模型 */
@property (strong,nonatomic) MSPCellModel * model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
