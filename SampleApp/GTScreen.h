//
//  GTScreen.h
//  SampleApp
//
//  Created by 曹亮 on 2020/4/21.
//  Copyright © 2020 曹亮. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

#define IS_LANDSCAPE (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))

#define SCREEN_WIDTH (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define UI(x) UIAdapter(x)
#define UIRect(x,y,width,height) UIRectAdapter(x,y,width,height)

#define IS_IPHONE_X_XR_MAX (IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XMAX)
#define IS_IPHONE_X (SCREEN_WIDTH == [GTScreen CGSizeFor58Inch].width && SCREEN_HEIGHT == [GTScreen CGSizeFor58Inch].height)
#define IS_IPHONE_XR (SCREEN_WIDTH == [GTScreen CGSizeFor61Inch].width && SCREEN_HEIGHT == [GTScreen CGSizeFor61Inch].height && [UIScreen mainScreen].scale == 2)
#define IS_IPHONE_XMAX (SCREEN_WIDTH == [GTScreen CGSizeFor65Inch].width && SCREEN_HEIGHT == [GTScreen CGSizeFor65Inch].height && [UIScreen mainScreen].scale == 3)


// 定义刘海屏高度

#define STATUSBARHEIGHT (IS_IPHONE_X_XR_MAX ? 44 : 20)

static inline NSInteger UIAdapter(float x) {
    // 两种方式实现
    // 1. 分机型 特定的比例
    // 2. 屏幕宽度按比例适配
    float scale = 414 / SCREEN_WIDTH;
    return x/scale;
}

static inline CGRect UIRectAdapter(x,y,width,height) {
    return CGRectMake(UIAdapter(x), UIAdapter(y), UIAdapter(width), UIAdapter(height));
}


@interface GTScreen : NSObject

+ (CGSize)CGSizeFor65Inch;

// iphone xr
+ (CGSize)CGSizeFor61Inch;

// iphonex
+ (CGSize)CGSizeFor58Inch;

@end

NS_ASSUME_NONNULL_END
