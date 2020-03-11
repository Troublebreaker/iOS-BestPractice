//
//  GTListItem.h
//  SampleApp
//
//  Created by 曹亮 on 2020/3/4.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTListItem : NSObject<NSSecureCoding>
@property (nonatomic,strong,readwrite) NSString *category;
@property (nonatomic,strong,readwrite) NSString *picUrl;
@property (nonatomic,strong,readwrite) NSString *uniqueKey;
@property (nonatomic,strong,readwrite) NSString *title;
@property (nonatomic,strong,readwrite) NSString *date;
@property (nonatomic,strong,readwrite) NSString *authorName;
@property (nonatomic,strong,readwrite) NSString *artileUrl;

- (void)configwithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
