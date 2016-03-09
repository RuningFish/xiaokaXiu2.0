//
//  MyVideoPlayer.h
//  自定义播放器
//
//  Created by admin on 16/2/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface MyVideoPlayer : UIView

/** 创建播放器 */
- (instancetype)initVideoPlayer;
/** 播放器 */
@property (strong,nonatomic) AVPlayer * player;
/** 定时器 */ 
@property (assign,nonatomic) NSTimer * timer;
@property (strong,nonatomic) AVPlayerItem * playerItem;
@end
