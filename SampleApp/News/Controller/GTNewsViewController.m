//
//  ViewController.m
//  SampleApp
//
//  Created by 曹亮 on 2020/3/2.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import "GTNewsViewController.h"
#import "GTNormalTableViewCell.h"
#import "GTDetailViewController.h"
#import "GTDeleteCellView.h"
#import "GTListLoader.h"

@interface TestView : UIView

@end

@implementation TestView

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
}

- (void)willMoveToWindow:(nullable UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
}

@end

// UIView生命周期
// 关注四个函数
//- (void)willMoveToSuperview:(nullable UIView *)newSuperview{
//    [super ]
//
//}
//- (void)didMoveToSuperview
//
//- (void)willMoveToWindow:(nullable UIWindow *)newWindow{
//
//}
//- (void)didMoveToWindow{
//
//}

@interface GTNewsViewController () <UITableViewDataSource, UITableViewDelegate, GTNormalTableViewCellDelegate>
@property (strong, nonatomic, readwrite) UITableView *tableView;
@property (strong, nonatomic, readwrite) NSArray *dataArray;
@property (strong, nonatomic, readwrite) GTListLoader *listLoader;

@end

@implementation GTNewsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
//        _dataArray = @[].mutableCopy;
//        for (int i = 0; i < 20; i++) {
//            [_dataArray addObject:@(i)];
//        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    self.listLoader = [[GTListLoader alloc] init];
    __weak typeof(self) wself = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<GTListItem *> * _Nonnull dataArray) {
       __strong typeof(self) strongSelf = wself;
       
        if(success) {
            strongSelf.dataArray = dataArray;
            [strongSelf.tableView reloadData];
        }
    }];

//    TestView * view = [[TestView alloc] init];
//    view.backgroundColor = [UIColor greenColor];
//    view.frame =CGRectMake(150, 150, 100, 100);
//    [self.view addSubview:view];
//    // view添加手势
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushController)];
//    [view addGestureRecognizer:tapGesture];
}

//- (void)pushController { //    UIViewController *viewController = [[UIViewController alloc] init];
//    viewController.view.backgroundColor = [UIColor whiteColor];
//    viewController.title = @"内容";
//    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"右侧标题" style:UIBarButtonItemStylePlain target:self action:nil];
//    [self.navigationController pushViewController:viewController animated:YES];
//
//}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[GTNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        cell.delegate = self;
    }
    [cell layoutTableViewCellWithItem:self.dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GTListItem *item = self.dataArray[indexPath.row];
    GTDetailViewController *controller = [[GTDetailViewController alloc] initWithUrlStr:item.artileUrl];
    controller.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item.uniqueKey];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)tableviewCell:(UITableViewCell *)tableviewCell clickDeleteButton:(UIButton *)deleteButton {
    GTDeleteCellView *view = [[GTDeleteCellView alloc] initWithFrame:self.view.bounds];
    CGRect rect = [tableviewCell convertRect:deleteButton.frame toView:nil];

    __weak typeof(self) wself = self;
    [view showDeleteViewFromPoint:rect.origin clickBlock:^{
        __strong typeof(self) strongSelf = wself;
        [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableviewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

@end
