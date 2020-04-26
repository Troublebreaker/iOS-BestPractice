//
//  GTScreen.m
//  SampleApp
//
//  Created by 曹亮 on 2020/4/21.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import "GTScreen.h"

@implementation GTScreen

// iphone xs max
+ (CGSize)CGSizeFor65Inch{
    return CGSizeMake(414,896);
}

// iphone xr
+ (CGSize)CGSizeFor61Inch{
    return CGSizeMake(414,896);
}

// iphonex
+ (CGSize)CGSizeFor58Inch{
    return CGSizeMake(375,812);
}
@end
