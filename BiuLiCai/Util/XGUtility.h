//
//  XGUtility.h
//  XGCG
//
//  Created by Owen on 15/4/27.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ColorModel;

@interface XGUtility : NSObject
+(UIColor *)kXGHexColor:(NSInteger)hexColor;
+(UIColor *)kXGHexColor:(NSInteger)hexColor alpha:(CGFloat)alpha;
+(ColorModel *)colorModelWithHexString:(NSInteger)hexColor withAlpha:(CGFloat)alpha;
+(UIImage *)kXGImageWithColor:(UIColor *)color;
@end

#define kXGNavigationBarTintColor ([XGUtility kXGHexColor:0x2c2a31])
#define kXGNavigationBarTextColor ([UIColor whiteColor])
#define kXGStockRizeTextColor ([XGUtility kXGHexColor:0xff5845])
#define kXGStockfallTextColor ([XGUtility kXGHexColor:0x1DBE5D])