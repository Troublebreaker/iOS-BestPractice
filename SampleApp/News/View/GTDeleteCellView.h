//
//  GTDeleteCellView.h
//  SampleApp
//
//  Created by 曹亮 on 2020/3/3.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTDeleteCellView : UIView



/// 点击确认删除Cell确认浮层
/// @param point 点击的位置
/// @param clickBlock 点击后的操作
- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock;
- (void)dimissDeleteView;

@end

NS_ASSUME_NONNULL_END
