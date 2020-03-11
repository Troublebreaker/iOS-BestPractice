//
//  GTVideoViewController.m
//  SampleApp
//
//  Created by 曹亮 on 2020/3/2.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import "GTVideoViewController.h"
#import "GTVideoCoverView.h"

@interface GTVideoViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation GTVideoViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"视频";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/video_normal"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/video_slected"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width , (self.view.frame.size.width )/16*9);
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[GTVideoCoverView class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.view addSubview:collectionView];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  20;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    if([cell isKindOfClass:[GTVideoCoverView class]]) {
        [(GTVideoCoverView *)cell layoutWithVideoCoverUrl:@"icon.bundle/video_cover.png" videoUrl:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    }
    return  cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
