//
//  GTVideoCoverView.m
//  SampleApp
//
//  Created by 曹亮 on 2020/3/5.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import "GTVideoCoverView.h"
#import <AVFoundation/AVFoundation.h>
#import "GTVideoPlayer.h"
#import "GTVideoToolBar.h"

@interface GTVideoCoverView()
@property (strong,readwrite,nonatomic) UIImageView *coverView;
@property (strong,readwrite,nonatomic) UIImageView *playButton;
@property (strong,readwrite,nonatomic) NSString *videoUrl;
@property (strong,readwrite,nonatomic) AVPlayerItem *videoItem;
@property (strong,readwrite,nonatomic) AVPlayer *avPlayer;
@property (strong,readwrite,nonatomic) AVPlayerLayer *playerLayer;
@property (strong,readwrite,nonatomic) GTVideoToolBar *toolBar;

@end


// TODO: List
// 1.监听视频播放的缓冲与进度  CMTime CMTimeMake

@implementation GTVideoCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - GTVideoToolBarHeight)];
            _coverView;
        })];
        [_coverView addSubview:({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 50)/2, (frame.size.height - 50)/2, 50, 50)];
            _playButton.image = [UIImage imageNamed:@"icon.bundle/video_play@3x.png"];
            _playButton;
        })];
        
        [self addSubview:({
            _toolBar = [[GTVideoToolBar alloc] initWithFrame:CGRectMake(0, _coverView.bounds.size.height , frame.size.width, GTVideoToolBarHeight)];
            _toolBar;
        })];
        
        // 添加手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];        

        
    }
    return self;
}

// 学习到的点：
// 1. cell自身需要保存一些必要的数据
// 2. cell内部按钮k也可以做一些数据处理


#pragma mark - private method
- (void)_tapToPlay{

//    NSURL * videourURL = [NSURL URLWithString:_videoUrl];
//    AVAsset * asset = [AVAsset assetWithURL:videourURL];
//
//    _videoItem = [AVPlayerItem playerItemWithAsset:asset];
//    _avPlayer = [AVPlayer playerWithPlayerItem:_videoItem];
//
//    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
//    _playerLayer.frame = _coverView.bounds;
//    [_coverView.layer addSublayer:_playerLayer];
//
//    [_avPlayer play];
    
    [[GTVideoPlayer Player] playVideoWithUrl:_videoUrl attachView:_coverView];

}


#pragma mark - public method
- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl {
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _videoUrl = videoUrl;
    [_toolBar layoutWithModel:nil];
}

@end
