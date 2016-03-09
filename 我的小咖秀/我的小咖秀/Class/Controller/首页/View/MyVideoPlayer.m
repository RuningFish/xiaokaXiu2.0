//
//  MyVideoPlayer.m
//  自定义播放器
//
//  Created by admin on 16/2/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MyVideoPlayer.h"

@interface MyVideoPlayer ()

@property (weak,nonatomic) AVPlayerLayer * playerLayer;
@property (weak,nonatomic) UIImageView * imageView;
@property (weak,nonatomic) UIProgressView * progressView; // 进度条
@property (weak,nonatomic) UIButton * pauseButton; // 暂停按钮

//@property (assign,nonatomic) CGFloat percent; // 进度百分比
@end
@implementation MyVideoPlayer

- (instancetype)initVideoPlayer{
    
    if (self = [super init]) {
        
        // imageView
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        self.imageView = imageView;
        [self addSubview:imageView];
        
        // 进度条
        UIProgressView * progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        self.progressView = progressView;
        progressView.trackTintColor = [UIColor lightGrayColor];
        progressView.progressTintColor = [UIColor yellowColor];
        
        [self addSubview:progressView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoPlayerDidPause)];
        [imageView addGestureRecognizer:tap];
        
        //imageView.backgroundColor = [UIColor greenColor];
        
        // 创建播放器
        self.player = [[AVPlayer alloc] init];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        [imageView.layer addSublayer:self.playerLayer];
        
        // 暂停按钮
        UIButton * pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.pauseButton = pauseButton;
        // 默认隐藏
        pauseButton.hidden = YES;
        [pauseButton setImage:[UIImage imageNamed:@"video_btn_pause_big"] forState:UIControlStateNormal];
        //pause.backgroundColor = [UIColor purpleColor];
        pauseButton.adjustsImageWhenHighlighted = NO;
        [pauseButton addTarget:self action:@selector(startPlay) forControlEvents:UIControlEventTouchDown];
        [self addSubview:pauseButton];
        
        [self removeTimer];
        
        // 添加定时器
        [self addTimer];

}
    
    return self;
}
/*************添加定时器****************/
- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/*************移除定时器****************/
- (void)removeTimer{
    
    [self.timer invalidate];
    
    self.timer = nil;
}

- (void)update{
    
    CGFloat currentTime = CMTimeGetSeconds(self.player.currentTime);
    CGFloat durationTime = CMTimeGetSeconds(self.player.currentItem.duration);

    CGFloat percent = currentTime / durationTime;

    // 进度条
    self.progressView.transform = CGAffineTransformMakeScale(1.0f,3.0f);
    self.progressView.progress = percent;
    [self.progressView setProgress:percent animated:YES];
//    UIView * progressView = [[UIView alloc] init];
//    CGFloat w = self.width;
//    CGFloat h = 5;
//    CGFloat x = -self.width;
//    CGFloat y = self.frame.size.height - h;
//    progressView.backgroundColor = [UIColor yellowColor];
//    [self.progressView addSubview:progressView];
//    progressView.frame = CGRectMake(x, y, w, h);
//    [UIView animateWithDuration:1.0 animations:^{
//        
//        progressView.transform = CGAffineTransformTranslate(progressView.transform, self.width * 2 * percent, 0);
//        
//    }];
//    NSLog(@"%@",NSStringFromCGRect(progressView.frame));

    // 如果视频播放完，则关闭定时器
    if (currentTime == durationTime ) {
        
        [self removeTimer];
    }
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
//    // 进度条
    CGFloat w = self.width;
    CGFloat h = 3;
    CGFloat x = 0;
    CGFloat y = self.frame.size.height - h;
   
    self.progressView.frame = CGRectMake(x, y, w, h);
  
    self.playerLayer.frame = self.bounds;
    
    // 暂停按钮
    CGFloat pauseWidth = 50;
    CGFloat pauseHeight = pauseWidth;
    CGFloat pauseX = (self.width - pauseWidth) * 0.5;
    CGFloat pauseY = (self.height - pauseHeight) * 0.5;
    self.pauseButton.frame = CGRectMake(pauseX, pauseY, pauseWidth, pauseHeight);
    
}

- (void)setPlayerItem:(AVPlayerItem *)playerItem{
    
    _playerItem = playerItem;
    
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [self.player play];
    
}

/************暂停播放****************/
- (void)videoPlayerDidPause{
    
    [self.player pause];
    // 移除定时器
    [self removeTimer];
    self.pauseButton.hidden = NO;
}

/************开始播放****************/
- (void)startPlay{
    
    [self.player play];
    
    [self addTimer];
    self.pauseButton.hidden = YES;
}

@end
