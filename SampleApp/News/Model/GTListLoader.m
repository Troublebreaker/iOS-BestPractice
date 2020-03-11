//
//  GTListLoader.m
//  SampleApp
//
//  Created by 曹亮 on 2020/3/4.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import "GTListLoader.h"
#import "GTListItem.h"
#import <AFNetworking/AFNetworking.h>

@implementation GTListLoader

// 实现思路:加载对应数据   使用Block将数据传出去
// 数据加载方式： 先缓存 后接口请求
- (void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock {
    NSArray <GTListItem *> *listdata = [self readListFromLocal];
    if (listdata) {
        finishBlock(YES, listdata.copy);
    }

    NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=b73d19306a5b809034bcb17f6c209f6a";
    NSURL *listURL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];

    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
#warning 类型的检查
        NSArray *dataArray = [((NSDictionary *)[((NSDictionary *)jsonObj) objectForKey:@"result"])objectForKey:@"data"];
        NSMutableArray *listItemArray = @[].mutableCopy;
        for (NSDictionary *info in dataArray) {
            GTListItem *item = [[GTListItem alloc] init];
            [item configwithDictionary:info];
            [listItemArray addObject:item];
        }
        // 数据缓存到本地
        [strongSelf _archiveListDataWithArray:listItemArray.copy];
        // 数据刷新页面驱动数据  刷新页面在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
                           if (finishBlock) {
                               finishBlock(error == nil, listItemArray.copy);
                           }
                       });
    }];
    [dataTask resume];

//    [[AFHTTPSessionManager manager] GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSLog(@"");
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        NSLog(@"");
//
//    }];
}

#pragma mark - private method
// 实现思路：使用NSUserDefault 实现基本数据类型的存储
// 技术进步最快的方式是读书学习
- (NSArray <GTListItem *> *)readListFromLocal {
    // 1. 创建文件
    // 2. 编写文件数据流

    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    NSString *listDataPath = [cachePath stringByAppendingPathComponent:@"GTData/list"];

    NSFileManager *fileManger = [NSFileManager defaultManager];

    NSData *readListData = [fileManger contentsAtPath:listDataPath];
    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [GTListItem class], nil] fromData:readListData error:nil];

    if ([unarchiveObj isKindOfClass:[NSArray class]] && [unarchiveObj count] > 0) {
        return (NSArray <GTListItem *> *)unarchiveObj;
    }
    return nil;
}

- (void)_archiveListDataWithArray:(NSArray<GTListItem *> *)array {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];

    //Cache下面 新建文件  编写数据 实现思路： 使用NSFileManager  NSFileHandler 两个类型进行管理

    NSFileManager *fileManager = [NSFileManager defaultManager];

    //创建文件夹
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"GTData"];
    NSError *createError;
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError];

    //创建文件
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"];
//    NSData *listData = [@"abc" dataUsingEncoding:NSUTF8StringEncoding];  // 字符串通过UTF8 编码转化为二进制文件
//    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];

    // 序列化文件
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
    //反序列化文件
    NSData *readListData = [fileManager contentsAtPath:listDataPath];
    id unarchiveObj =  [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [GTListItem class], nil] fromData:readListData error:nil];

    // 查询文件
//    BOOL fileExist = [fileManager fileExistsAtPath:listDataPath];

//    //删除
//    if(fileExist) {
//        [fileManager removeItemAtPath:listDataPath error:nil];
//    }

    // 文件写入
//    NSFileHandle *fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:listDataPath];
//    [fileHandler seekToEndOfFile];
//    [fileHandler writeData:[@"def" dataUsingEncoding:NSUTF8StringEncoding]];
//
//    [fileHandler synchronizeFile];
//    [fileHandler closeFile];
}

@end
