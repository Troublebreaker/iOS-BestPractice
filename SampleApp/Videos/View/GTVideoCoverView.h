//
//  GTVideoCoverView.h
//  SampleApp
//
//  Created by 曹亮 on 2020/3/5.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTVideoCoverView : UICollectionViewCell
- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl;
@end

NS_ASSUME_NONNULL_END
