//
//  GTRecommandViewController.m
//  SampleApp
//
//  Created by 曹亮 on 2020/3/3.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import "GTRecommandViewController.h"

@interface GTRecommandViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation GTRecommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 学习使用 UIScrollView
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];

    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width *5, self.view.bounds.size.height);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;

    
    NSArray *colorArray = @[[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor lightGrayColor],[UIColor grayColor]];
    
    for(int i=0; i<5; i++) {
        [scrollView addSubview:({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollView.bounds.size.width *i, 0, scrollView.bounds.size
                                                                    .width, scrollView.bounds.size.height)];
            view.backgroundColor = [colorArray objectAtIndex:i];
            [view addSubview:({
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
                view.backgroundColor = [UIColor yellowColor];
                
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
                tapGesture.delegate = self;
                [view addGestureRecognizer:tapGesture];
                view;
            })];
            view;
        })];
    }
    [self.view addSubview:scrollView];
    
}


- (void)viewClick {
    NSLog(@"viewClick");
}



- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return  YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}
@end
