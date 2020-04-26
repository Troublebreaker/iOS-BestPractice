//
//  GTVideoPlayer.h
//  SampleApp
//
//  Created by 曹亮 on 2020/3/16.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


// 单例播放器
@interface GTVideoPlayer : NSObject
// 设置单例
+ (GTVideoPlayer *)Player;
- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView* )attachView;
@end

NS_ASSUME_NONNULL_END
