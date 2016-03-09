//
//  MSPMoreCell.m
//  我的锁屏
//
//  Created by admin on 16/1/30.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MSPMoreCell.h"
#import "MSPMoreCell.h"
#import "MSPCellModel.h"
#import "MSPArrowCell.h"
#import "MSPSwitchCell.h"

@interface MSPMoreCell ()
/** 箭头 */
@property (strong,nonatomic) UIImageView * arrowView;
/** 开关 */
@property (strong,nonatomic) UISwitch * switchView;

@property (weak,nonatomic) UIView * bottomLine;
@end

@implementation MSPMoreCell
static NSString * ID = @"MSPCell";


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView * bottomLine = [[UIView alloc] init];
        self.bottomLine = bottomLine;
        bottomLine.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:bottomLine];
        
        //self.layer.contents = (id)[UIImage imageNamed:@"head_top_bg"].CGImage;
        self.backgroundColor = [UIColor blackColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:13];
      
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat margin = 10;
    CGFloat w = self.width - margin * 2;
    CGFloat h = 1;
    CGFloat y = self.height - h;
    
    self.bottomLine.frame = CGRectMake(margin, y, w, h);
}
- (UIImageView *)arrowView{
    
    if (_arrowView == nil) {
        
        // switch_checkbox_on switch_checkbox_off
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow@2x"]];
        
    }
    
    return _arrowView;
}

- (UISwitch *)switchView{
    
    if (_switchView == nil) {
        
        _switchView = [[UISwitch alloc] init];
        
//        _switchView.onImage = [UIImage imageNamed:@"switch_checkbox_on"];
//        _switchView.offImage = [UIImage imageNamed:@"switch_checkbox_off"];
        _switchView.onTintColor = [UIColor yellowColor];
        
        // 监听开关状态
        [self.switchView addTarget:self action:@selector(switchViewDidClick) forControlEvents:UIControlEventValueChanged];
        
    }
    
    return _switchView;
}

- (void)switchViewDidClick{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:self.switchView.isOn forKey:self.model.title];
    
    [defaults synchronize];
    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    MSPMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[MSPMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        //cell.textLabel.textColor = MSPColor;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}

- (void)setModel:(MSPCellModel *)model{
    
    _model = model;
    
    [self setData];
    
    [self setRightContent];
    
}

- (void)setData
{
    self.imageView.image = [UIImage imageNamed:self.model.icon];
    self.textLabel.text = self.model.title;
}

- (void)setRightContent
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // 通过判断模型cell的类型来决定右面内容的样式
    if ([self.model isKindOfClass:[MSPArrowCell class]]) {// 带箭头
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if ([self.model isKindOfClass:[MSPSwitchCell class]]){// 带开关
        
        self.accessoryView = self.switchView;
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        
        self.switchView.on = [defaults boolForKey:self.model.title];
    }else{
        
        self.accessoryView = nil;
    }
}

@end
