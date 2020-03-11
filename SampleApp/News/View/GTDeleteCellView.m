//
//  GTDeleteCellView.m
//  SampleApp
//
//  Created by 曹亮 on 2020/3/3.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import "GTDeleteCellView.h"


@interface GTDeleteCellView()
@property(strong,nonatomic,readwrite) UIView * backgroundView;
@property(strong,nonatomic,readwrite) UIButton * deleteButton;
@property(copy,nonatomic,readwrite) dispatch_block_t deleteBlock;

@end

@implementation GTDeleteCellView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self addSubview:({
            _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
            _backgroundView.backgroundColor = [UIColor blackColor];
            _backgroundView.alpha = 0.5;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimissDeleteView)];
            [_backgroundView addGestureRecognizer:tapGesture];
            _backgroundView;
        })];
        [self addSubview:({
            _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            [_deleteButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
            _deleteButton.backgroundColor = [UIColor blueColor];
            _deleteButton;
        })];
    }
    return  self;
}


- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock{
    _deleteButton.frame = CGRectMake(point.x, point.y, 0, 0);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _deleteBlock = [clickBlock copy];
    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.deleteButton.frame = CGRectMake((self.bounds.size.width -200)/2, (self.bounds.size.height -200)/2, 200, 200);

    } completion:^(BOOL finished) {
    }];
}

- (void)dimissDeleteView{
    [self removeFromSuperview];
}

- (void)clickButton{
    
    if(_deleteBlock) {
        _deleteBlock();
    }
    [self removeFromSuperview];
}

@end
