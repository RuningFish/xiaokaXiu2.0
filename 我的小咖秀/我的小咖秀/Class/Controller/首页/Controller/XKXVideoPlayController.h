//
//  XKXVideoPlayController.h
//  我的小咖秀
//
//  Created by admin on 16/2/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XKXVideoPlayController : UIViewController
/** 用于存放视频播放器的view */
@property (strong,nonatomic) UIView * videoView;

/** 播放器 */
@property (strong,nonatomic) MyVideoPlayer * videoPlayer;
@end
