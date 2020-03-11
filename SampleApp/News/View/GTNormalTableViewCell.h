//
//  GTNormalTableViewCell.h
//  SampleApp
//
//  Created by 曹亮 on 2020/3/3.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTListItem.h"

NS_ASSUME_NONNULL_BEGIN

//实现功能点击*实现弹出整个动画浮层
@protocol GTNormalTableViewCellDelegate <NSObject>
- (void)tableviewCell:(UITableViewCell *)tableviewCell clickDeleteButton:(UIButton *)deleteButton;
@end

// 实现代理方法 点击对应事件
@interface GTNormalTableViewCell : UITableViewCell
@property (weak,nonatomic,readwrite) id<GTNormalTableViewCellDelegate> delegate;
- (void)layoutTableViewCellWithItem:(GTListItem *)item;
@end

NS_ASSUME_NONNULL_END
