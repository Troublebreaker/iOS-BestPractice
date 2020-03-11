
//
//  GTListItem.m
//  SampleApp
//
//  Created by 曹亮 on 2020/3/4.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import "GTListItem.h"

@implementation GTListItem

#pragma mark NSCoding
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self){
        self.category = [aDecoder decodeObjectForKey:@"category"];
        self.picUrl = [aDecoder decodeObjectForKey:@"picUrl"];
        self.uniqueKey = [aDecoder decodeObjectForKey:@"uniqueKey"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.authorName = [aDecoder decodeObjectForKey:@"authorName"];
        self.artileUrl = [aDecoder decodeObjectForKey:@"artileUrl"];
    }
    return  self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.category forKey:@"category"];
    [aCoder encodeObject:self.picUrl forKey:@"picUrl"];
    [aCoder encodeObject:self.uniqueKey forKey:@"uniqueKey"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.authorName forKey:@"authorName"];
    [aCoder encodeObject:self.artileUrl forKey:@"artileUrl"];
}

+ (BOOL)supportsSecureCoding{
    return YES;
}


#pragma mark - Public Method
- (void)configwithDictionary:(NSDictionary *)dictionary {

#warning 类型是否匹配
    self.category = [dictionary objectForKey:@"category"];
    self.picUrl = [dictionary objectForKey:@"thumbnail_pic_s"];
    self.uniqueKey = [dictionary objectForKey:@"uniqueKey"];
    self.title = [dictionary objectForKey:@"title"];
    self.date = [dictionary objectForKey:@"date"];
    self.authorName = [dictionary objectForKey:@"author_name"];
    self.artileUrl = [dictionary objectForKey:@"url"];

}

@end
