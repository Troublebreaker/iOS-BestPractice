//
//  GTNormalTableViewCell.m
//  SampleApp
//
//  Created by 曹亮 on 2020/3/3.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import "GTNormalTableViewCell.h"
#import <SDWebImage/SDWebImage.h>


@interface GTNormalTableViewCell()
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *sourceLabel;
@property (nonatomic, strong, readwrite) UILabel *commentLabel;
@property (nonatomic, strong, readwrite) UILabel *timeLabel;
@property (nonatomic, strong, readwrite) UIImageView *rightImageView;
@property (nonatomic, strong, readwrite) UIButton *deleteButton;

@end

@implementation GTNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
        [self.contentView addSubview:({
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 270, 50)];
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            self.titleLabel.numberOfLines = 2;
            self.titleLabel;
        })];
        
        [self.contentView addSubview:({
            self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 50, 20)];
            self.sourceLabel.font = [UIFont systemFontOfSize:12];
            self.sourceLabel.textColor = [UIColor grayColor];

            self.sourceLabel;
        })];
        
        [self.contentView addSubview:({
            self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, 50, 20)];
            self.commentLabel.font = [UIFont systemFontOfSize:12];
            self.commentLabel.textColor = [UIColor grayColor];

            self.commentLabel;
        })];
        [self.contentView addSubview:({
            self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 70, 50, 20)];
            self.timeLabel.font = [UIFont systemFontOfSize:12];
            self.timeLabel.textColor = [UIColor grayColor];
            self.timeLabel;
              })];
        
        [self.contentView addSubview:({
            self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 15, 100, 70)];
            self.rightImageView;
        })];
//        [self.contentView addSubview:({
//            self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(290, 80, 30, 20)];
//            self.deleteButton.backgroundColor = [UIColor blueColor];
//            [self.deleteButton setTitle:@"X" forState:UIControlStateNormal];
//            [self.deleteButton setTitle:@"V" forState:UIControlStateHighlighted];
//            [self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
//            self.deleteButton;
//        })];
        
    }
    return  self;
}

- (void)layoutTableViewCellWithItem:(GTListItem *)item{
    
    BOOL hasRead = [[NSUserDefaults standardUserDefaults] boolForKey:item.uniqueKey];
    if(hasRead) {
        self.titleLabel.textColor = [UIColor lightGrayColor];
    }else {
        self.titleLabel.textColor = [UIColor blackColor];
    }
    self.titleLabel.text = item.title;
    self.sourceLabel.text =item.authorName;
    [self.sourceLabel sizeToFit];
    self.commentLabel.text =item.category;
    self.commentLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width +15 , self.commentLabel.frame.origin.y, self.commentLabel.frame.size
                                         .width, self.commentLabel.frame.size.height);
    [self.commentLabel sizeToFit];

    self.timeLabel.text = item.date;
    [self.timeLabel sizeToFit];
    self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width +15 , self.commentLabel.frame.origin.y, self.timeLabel.frame.size
                                            .width, self.timeLabel.frame.size.height);
    
#warning 图片加载形式优化
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.picUrl]]];
//    self.rightImageView.image = image;

    //    两种方式实现  NSThread  GCD方式实现
//    NSThread * downloadImageThread =[[NSThread alloc] initWithBlock:^{
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.picUrl]]];
//        self.rightImageView.image = image;
//    }];
//    downloadImageThread.name = @"downloadImageThread";
//    [downloadImageThread start];
    
    //GCD 实现： 下载线程下载数据 主线程更新UI
//    dispatch_queue_global_t downloadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_main_t mainQueue = dispatch_get_main_queue();
//    dispatch_async(downloadQueue, ^{
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.picUrl]]];
//        dispatch_async(mainQueue, ^{
//            self.rightImageView.image = image;
//        });
//    });
    
    // 使用三方框架提供的一系列对应图片对应管理  下载 缓存 存储策略
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:item.picUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)deleteButtonClick {
    if(self.delegate && [self.delegate respondsToSelector:@selector(tableviewCell:clickDeleteButton:)]) {
        [self.delegate tableviewCell:self clickDeleteButton:self.deleteButton];
    }
}

@end
