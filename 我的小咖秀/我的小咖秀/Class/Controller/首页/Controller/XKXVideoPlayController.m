//
//  XKXVideoPlayController.m
//  我的小咖秀
//
//  Created by admin on 16/2/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "XKXVideoPlayController.h"
#import "XKXToolsView.h"
@interface XKXVideoPlayController ()<XKXToolsViewDelegate>
//@property (strong,nonatomic) AVPlayer * player;
@property (assign,nonatomic) NSTimer * timer;
@property (strong,nonatomic) NSMutableArray * danmu;
@end

@implementation XKXVideoPlayController

- (NSMutableArray *)danmu{
    
    if (_danmu == nil) {
        
        _danmu = [NSMutableArray array];
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"danmu.plist" ofType:nil];
        NSArray * arr = [NSArray arrayWithContentsOfFile:filePath];
     
        for (NSDictionary * dict in arr) {
            
            [_danmu addObject:dict];
        }
    }
    
    return _danmu;
}
- (UIView *)videoView{
    
    UIView * videoView = [[UIView alloc] init];
    CGFloat w = self.view.width;
    CGFloat h = w;
    CGFloat x = 0;
    CGFloat y = 104;
    //videoView.backgroundColor = [UIColor yellowColor];
    videoView.frame = CGRectMake(x, y, w, h);
    
    [self.view addSubview:videoView];
    return videoView;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // 背景
    UIImageView * bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:bgView];
    
    // 左边按钮
    WTBarButtonItem * left = [WTBarButtonItem tabBarButtonWithTitle:nil andImage:@"back_btn_2_n"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    
    [left addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 中间文字
    self.navigationItem.title = @"视频详情";
    // 右边按钮
    UIButton * right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.adjustsImageWhenHighlighted = NO;
    [right setImage:[UIImage imageNamed:@"danma_closed"] forState:UIControlStateNormal];
    right.frame = CGRectMake(0, 0, 40, 25);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    [right addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    // 工具条
    [self setUpToolView];
    
    //[self addTimer];
   
}
/****************创建工具条***************/
- (void)setUpToolView{
    
    CGFloat w = self.view.width;
    CGFloat h = 40;
    CGFloat x = 0;
//NSLog(@"---%@",NSStringFromCGRect(self.videoView.frame));
    CGFloat y = CGRectGetMaxY(self.videoView.frame) + 30;
    
    u_int32_t loveCount = arc4random_uniform(200);
    NSString * love = [NSString stringWithFormat:@"%d",loveCount];
    NSArray * str = @[love,@"分享",@"更多"];
    XKXToolsView * toolView = [[XKXToolsView alloc] initFrame:CGRectMake(x, y, w, h) andArray:str];
    //toolView.imageArr = @[@"btn_love_p",@"btn_share",@"btn_right_more_n"];
    toolView.delegate = self;
    [self.view addSubview:toolView];
    
}

- (void)leftButtonClick {
    
    // 1.退出控制器
    [self.navigationController popViewControllerAnimated:YES];
    // 2.暂停播放
    [self.videoPlayer.player pause];
    // 3. 关闭定时器
    [self.videoPlayer.timer invalidate];
}

- (void)rightButtonClick:(UIButton *)button {
    
    if ([button.currentImage isEqual:[UIImage imageNamed:@"danma_closed"]]) {// 开启弹幕
        
        [button setImage:[UIImage imageNamed:@"danma_opened"] forState:UIControlStateNormal];
       // [self.player pause];
        [self addTimer];
        
    }else{// 关闭弹幕
        
        [button setImage:[UIImage imageNamed:@"danma_closed"] forState:UIControlStateNormal];
       // [self.player play];
        [self removeTimer];
    }
}

/** 添加定时器 */
- (void)addTimer{
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(creatLabel) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/** 移除定时器 */
- (void)removeTimer{
    
    [self.timer invalidate];
    self.timer = nil;
}
/** 创建滚动弹幕的label */
- (void)creatLabel{
    
    UILabel * label = [[UILabel alloc] init];
    CGFloat y = arc4random_uniform(self.view.width -50);
    label.frame = CGRectMake(320, y, 250, 30);
    
    NSDictionary * dict = [self.danmu objectAtIndex:arc4random_uniform((int)self.danmu.count)];
    label.text = dict[@"m"];
    label.textColor = XKXColor;
    [self.videoView addSubview:label];
    
    [self move:label];
    //NSLog(@"%@",NSStringFromCGRect(label.frame));
}

/** 创建滚动弹幕的label */
- (void)move:(UILabel *)label{
    
    [UIView animateWithDuration:4.0 animations:^{
        
        label.frame = CGRectMake(-250, label.frame.origin.y, label.frame.size.width, label.frame.size.height);
    } completion:^(BOOL finished) {
        
        [label removeFromSuperview];
    }];
}
/****************toolsView的代理方法***************/
- (void)toolView:(XKXToolsView *)toolView witnController:(UIViewController *)controller{
    
    [self presentViewController:controller animated:YES completion:nil];
}
@end
