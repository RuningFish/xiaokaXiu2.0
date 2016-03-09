//
//  XKXHomeController.m
//  我的小咖秀
//
//  Created by admin on 16/2/17.
//  Copyright © 2016年 admin. All rights reserved.
//  首页

#import "XKXHomeController.h"
#import "XKXButton.h"
#import "XKXHomeModel.h"
#import "XKXHomeVideoCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "XKXVideoPlayController.h"

@interface XKXHomeController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/** collectionView */
@property (weak,nonatomic) UICollectionView * collectionView;
/** 遮盖 */
@property (weak,nonatomic) UIImageView * bgView;

/** 数据 */
@property (strong,nonatomic) NSMutableArray * data;
//@property (strong,nonatomic) MyVideoPlayer * player;
@end

@implementation XKXHomeController

static NSString * ID = @"HomeVideo";
- (NSMutableArray *)data{
    
    if (_data == nil) {
        
        _data = [NSMutableArray array];
        
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"discover.plist" ofType:nil];
        
        NSDictionary * dictArr = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        NSArray * tmp = dictArr[@"videos"];
        
        for (NSDictionary * dict in tmp) {
            
            XKXHomeModel * video = [XKXHomeModel videoWithDictionary:dict];
            
            [_data addObject:video];
        }
    }
    
    return _data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 右边按钮
    WTBarButtonItem * right = [WTBarButtonItem tabBarButtonWithTitle:nil andImage:@"recorder_img_btn"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    [right addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray * strArray = @[@"关注",@"发现",@"同城"];
    // 中间按钮
   WTSelectedView * selectedView = [[WTSelectedView alloc] initWithFrame:CGRectMake(0, 0, 150, 30) andArray:strArray];
   self.navigationItem.titleView = selectedView;
    
    [self setUpCollectionView];
  
}

/********************右侧按钮点击**********************/
- (void)rightButtonClick {
    
    // 背景
    UIImageView * bgView = [[UIImageView alloc] init];
    [self.navigationController.view addSubview:bgView];
    bgView.frame = self.view.bounds;
    self.bgView = bgView;
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.9;
    
    // 添加点击手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClick)];
    [bgView addGestureRecognizer:tap];
    
    // 按钮
    NSArray * str = @[@"对嘴",@"合演",@"原创"];
    NSArray * img = @[@"icon_bg_recorder",@"icon_bg_together",@"icon_bg_original"];
    
    long count = str.count;
    CGFloat w = 115;
    CGFloat h = w;
    CGFloat x = (self.view.frame.size.width - w) * 0.5;
    CGFloat margin = 30;
    CGFloat top = (self.view.frame.size.height - str.count * h - (count - 1) * margin) * 0.5;

    for (int i = 0; i < count; i ++) {
        
        XKXButton * button = [[XKXButton alloc] init];
        
        int col = i % count;
        CGFloat y = (col * (h + margin)) + top;
        //button.backgroundColor = XKXColor;
        button.frame = CGRectMake(x, y, w, h);
        // 文字
        [button setTitle:str[i] forState:UIControlStateNormal];
        // 图片
   
        [button setImage:[UIImage imageNamed:img[i]] forState:UIControlStateNormal];
        
        [bgView addSubview:button];
                
    }
}

/********************创建collectionView**********************/
- (void)setUpCollectionView{
    
    // 1.创建布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 1.1 设置item的宽高
    CGFloat itemWidth = (self.view.width - 1) * 0.5;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
   // layout.sectionInset = UIEdgeInsetsMake(0, margin, margin, 0);
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    // 2.创建collectionView
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor blackColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    collectionView.showsVerticalScrollIndicator = NO;
//    collectionView.scrollsToTop = YES;

    // 3.注册cell
    [collectionView registerClass:[XKXHomeVideoCell class] forCellWithReuseIdentifier:ID];
}

- (void)bgViewClick{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.bgView removeFromSuperview];
        
    }];
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    XKXHomeVideoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = XKXColor;
    
    cell.video = self.data[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XKXHomeModel * video = self.data[indexPath.item];
    
    NSLog(@"%@",video.video);
    // 视频的播放地址
    NSString * string = [[NSBundle mainBundle] pathForResource:video.video ofType:nil];
    
    if (!string){
    
        NSLog(@"%@",string);
        return;
    }
//NSLog(@"string ----- %@", string);
    NSURL * url = [NSURL fileURLWithPath:string];
// NSLog(@"url---- %@",url);
//    // 创建视频控制器
//    MPMoviePlayerViewController * player = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
//    
//    player.view.frame = CGRectMake(0, 20, self.view.width, 200);
//    [self presentMoviePlayerViewControllerAnimated:player];
    
    // 创建导航控制器
    XKXVideoPlayController * playVc = [[XKXVideoPlayController alloc] init];
    //XKXNavigationController * nav = [[XKXNavigationController alloc] initWithRootViewController:playVc];
    //playVc.view.backgroundColor = [UIColor greenColor];

    // 创建avplayer
//    AVPlayerItem * item = [AVPlayerItem playerItemWithURL:url];
//    self.player = [AVPlayer playerWithPlayerItem:item];
//    playVc.player = self.player;
//    AVPlayerLayer * layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//
//    layer.frame = CGRectMake(0, 0, playVc.view.width, playVc.view.width);
//    [playVc.videoView.layer addSublayer:layer];
//    [self.player play];
    
    MyVideoPlayer * player = [[MyVideoPlayer alloc] initVideoPlayer];
    playVc.videoPlayer = player;
    
    //playVc.player = player.player;
    player.playerItem = [AVPlayerItem playerItemWithURL:url];
    player.frame = CGRectMake(0, 0, playVc.view.width, playVc.view.width);
    [playVc.videoView addSubview:player];
    
    [self.navigationController pushViewController:playVc animated:YES];
}
@end
