//
//  GTVideoPlayer.m
//  SampleApp
//
//  Created by 曹亮 on 2020/3/16.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import "GTVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface  GTVideoPlayer()
@property (strong,readwrite,nonatomic) AVPlayerItem *videoItem;
@property (strong,readwrite,nonatomic) AVPlayer *avPlayer;
@property (strong,readwrite,nonatomic) AVPlayerLayer *playerLayer;

@end

// TODO: List: 迭代使用  AVPlayerViewController
//  提供 暂停 全屏 进度条  设置m播放器展示大小，全屏， 画中画
//  提供对应代理


@implementation GTVideoPlayer


+ (GTVideoPlayer *)Player {
    static GTVideoPlayer * player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[GTVideoPlayer alloc] init];
    });
    return player;
}



#pragma mark - private method


- (void)playVideoWithUrl:(NSString *)url attachView:(UIView* )attachView{
    [self _stopPlay];
    //播放实现思路：
    // 1. AVASSET AVITem AVPLAyER
    NSURL * videoUrl = [NSURL URLWithString:url];
    AVAsset *asset = [AVAsset assetWithURL:videoUrl];
//
    _videoItem = [[AVPlayerItem alloc] initWithAsset:asset];
    [_videoItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_videoItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    CMTime duration = _videoItem.duration;
    __unused CGFloat videoDuration = CMTimeGetSeconds(duration);

    _avPlayer = [AVPlayer playerWithPlayerItem:_videoItem];
    // 1 s中回调一次  播放进度的获取
    [_avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSLog(@"播放进度: %@",@(CMTimeGetSeconds(time)));
    }];

 
//    _avPlayer = [AVPlayer playerWithURL:videoUrl];
//
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    _playerLayer.frame = attachView.bounds;
    [attachView.layer addSublayer:_playerLayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_stopPlay) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    NSLog(@"");
}


- (void)_stopPlay{
    [_playerLayer removeFromSuperlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 移除KVO监听
    [_videoItem removeObserver:self forKeyPath:@"status"];
    [_videoItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    
    
    // 销毁播放器
    [_playerLayer removeFromSuperlayer];
    _videoItem = nil;
    _avPlayer = nil;
    
//    [_avPlayer seekToTime:CMTimeMake(0, 1)];
}


- (void)_handlePlayEnd{
    // 播放完成后循环播放
    [_avPlayer seekToTime:CMTimeMake(0, 1)];
    [_avPlayer play];
}



#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"status"]) {
        
        if (((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerItemStatusReadyToPlay ){
           //在合适的时机开始播放
            [_avPlayer play];
            
        } else {
            // 监控错误
        }
        
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSLog(@"缓冲:%@",[change objectForKey:NSKeyValueChangeNewKey]);
    }
}

@end
