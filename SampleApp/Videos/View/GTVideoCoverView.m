//
//  GTVideoCoverView.m
//  SampleApp
//
//  Created by 曹亮 on 2020/3/5.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import "GTVideoCoverView.h"
#import <AVFoundation/AVFoundation.h>
@interface GTVideoCoverView()
@property (strong,readwrite,nonatomic) UIImageView *coverView;
@property (strong,readwrite,nonatomic) UIImageView *playButton;
@property (strong,readwrite,nonatomic) NSString *videoUrl;
@property (strong,readwrite,nonatomic) AVPlayer *avPlayer;
@property (strong,readwrite,nonatomic) AVPlayerLayer *playerLayer;

@end

@implementation GTVideoCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            _coverView;
        })];
        [_coverView addSubview:({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 50)/2, (frame.size.height - 50)/2, 50, 50)];
            _playButton;
        })];
        // 添加手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self.coverView addGestureRecognizer:tapGesture];
//
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
//
//         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemNewErrorLogEntryNotification object:nil];
        
    }
    return self;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@",change);
}

#pragma mark - private method
- (void)_tapToPlay{
    //播放实现思路：
    // 1. AVASSET AVITem AVPLAyER
    NSURL * videoUrl = [NSURL URLWithString:_videoUrl];
    
//    AVAsset *asset = [AVAsset assetWithURL:videoUrl];
//
//    AVPlayerItem * videoItem = [[AVPlayerItem alloc] initWithAsset:asset];
//    AVPlayer *avPlayer = [AVPlayer playerWithPlayerItem:videoItem];

    _avPlayer = [AVPlayer playerWithURL:videoUrl];
//
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    _playerLayer.frame = _coverView.bounds;
    [_coverView.layer addSublayer:_playerLayer];
    [self.avPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_avPlayer play];
}


- (void)_handlePlayEnd{
    NSLog(@"");
}

#pragma mark - public method
- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl {
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _videoUrl = videoUrl;
    _playButton.image = [UIImage imageNamed:@"icon.bundle/video_play@3x.png"];
}


@end
