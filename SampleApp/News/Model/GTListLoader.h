//
//  GTListLoader.h
//  SampleApp
//
//  Created by 曹亮 on 2020/3/4.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class GTListItem;
typedef void(^GTListLoaderFinishBlock) (BOOL success, NSArray<GTListItem *> *dataArray);



/// 列表请求
@interface GTListLoader : NSObject
- (void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock )finishBlock;
@end

NS_ASSUME_NONNULL_END
