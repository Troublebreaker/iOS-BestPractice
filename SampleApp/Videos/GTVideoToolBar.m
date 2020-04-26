//
//  GTVideoToolBar.m
//  SampleApp
//
//  Created by 曹亮 on 2020/4/20.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import "GTVideoToolBar.h"

@interface GTVideoToolBar()
@property(nonatomic,strong,readwrite) UIImageView * avatorImageView;
@property(nonatomic,strong,readwrite) UILabel * nickNameLabel;
@property(nonatomic,strong,readwrite) UIImageView * commmentImageView;
@property(nonatomic,strong,readwrite) UILabel * commentLabel;
@property(nonatomic,strong,readwrite) UIImageView * likeImageView;
@property(nonatomic,strong,readwrite) UILabel * likeLabel;
@property(nonatomic,strong,readwrite) UIImageView * shareImageView;
@property(nonatomic,strong,readwrite) UILabel * shareLabel;

@end

@implementation GTVideoToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:({
            _avatorImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            _avatorImageView.layer.cornerRadius = 15;
            _avatorImageView.layer.masksToBounds = YES;
            _avatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
            _avatorImageView;
        })];
        
        [self addSubview:({
            _nickNameLabel = [[UILabel alloc] init];
            _nickNameLabel.font = [UIFont systemFontOfSize:15];
            _nickNameLabel.textColor = [UIColor lightGrayColor];
            _nickNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _nickNameLabel;
        })];
        [self addSubview:({
            _commmentImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            _commmentImageView.layer.cornerRadius = 15;
            _commmentImageView.layer.masksToBounds = YES;
            _commmentImageView.translatesAutoresizingMaskIntoConstraints = NO;
            _commmentImageView;
        })];

        [self addSubview:({
            _commentLabel = [[UILabel alloc] init];
            _commentLabel.font = [UIFont systemFontOfSize:15];
            _commentLabel.textColor = [UIColor lightGrayColor];
            _commentLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _commentLabel;
        })];
        
        [self addSubview:({
            _likeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            _likeImageView.layer.cornerRadius = 15;
            _likeImageView.layer.masksToBounds = YES;
            _likeImageView.translatesAutoresizingMaskIntoConstraints = NO;
            _likeImageView;
        })];

        [self addSubview:({
            _likeLabel = [[UILabel alloc] init];
            _likeLabel.font = [UIFont systemFontOfSize:15];
            _likeLabel.textColor = [UIColor lightGrayColor];
            _likeLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _likeLabel;
        })];


        [self addSubview:({
            _shareImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            _shareImageView.layer.cornerRadius = 15;
            _shareImageView.layer.masksToBounds = YES;
            _shareImageView.translatesAutoresizingMaskIntoConstraints = NO;
            _shareImageView;
        })];

        [self addSubview:({
            _shareLabel = [[UILabel alloc] init];
            _shareLabel.font = [UIFont systemFontOfSize:15];
            _shareLabel.textColor = [UIColor lightGrayColor];
            _shareLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _shareLabel;
        })];
        

    }
    return self;
}


// 使用AutoLayout进行布局

- (void)layoutWithModel:(id)model{
    _avatorImageView.image = [UIImage imageNamed:@"icon.bundle/icon.png"];
    _nickNameLabel.text = @"极客时间";
    
    _commmentImageView.image = [UIImage imageNamed:@"comment"];
    _commentLabel.text = @"100";
    
    _likeImageView.image = [UIImage imageNamed:@"praise"];
    _likeLabel.text = @"25";
    
    _shareImageView.image = [UIImage imageNamed:@"share"];
    _shareLabel.text = @"分享";
    
    [NSLayoutConstraint activateConstraints:@[
        [NSLayoutConstraint constraintWithItem:_avatorImageView attribute: NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:_avatorImageView attribute: NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:15],
        [NSLayoutConstraint constraintWithItem:_avatorImageView attribute: NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30],
        [NSLayoutConstraint constraintWithItem:_avatorImageView attribute: NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30],
        [NSLayoutConstraint constraintWithItem:_nickNameLabel attribute: NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:_nickNameLabel attribute: NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_avatorImageView attribute:NSLayoutAttributeRight multiplier:1 constant:0],

    ]];
    
    // 使用VFL实现
    NSString * vflString = @"H:|-15-[_avatorImageView]-0-[_nickNameLabel]-(>=0)-[_commmentImageView(==_avatorImageView)]-0-[_commentLabel]-15-[_likeImageView(==_avatorImageView)]-0-[_likeLabel]-15-[_shareImageView(==_avatorImageView)]-0-[_shareLabel]-15-|";
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflString options: NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_avatorImageView,_nickNameLabel,_commmentImageView,_commentLabel,_likeImageView,_likeLabel,_shareImageView,_shareLabel)]];
    
    
}

@end
