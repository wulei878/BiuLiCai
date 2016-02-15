//
//  XGUtility.m
//  XGCG
//
//  Created by Owen on 15/4/27.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGUtility.h"
#import "ColorModel.h"

@implementation XGUtility
+(UIColor *)kXGHexColor:(NSInteger)hexColor
{
    return [XGUtility kXGHexColor:hexColor alpha:1.0];
}

+(UIColor *)kXGHexColor:(NSInteger)hexColor alpha:(CGFloat)alpha
{
    CGFloat red = ((hexColor & 0xff0000) >> 16) / 255.0;
    CGFloat green = ((hexColor & 0x00ff00) >> 8) / 255.0;
    CGFloat blue = (hexColor & 0x0000ff) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+(ColorModel *)colorModelWithHexString:(NSInteger)hexColor withAlpha:(CGFloat)alpha
{
    CGFloat red = ((hexColor & 0xff0000) >> 16) / 255.0;
    CGFloat green = ((hexColor & 0x00ff00) >> 8) / 255.0;
    CGFloat blue = (hexColor & 0x0000ff) / 255.0;
    ColorModel *rgb = [[ColorModel alloc] init];
    rgb.R = red;
    rgb.B = blue;
    rgb.G = green;
    rgb.alpha = alpha;
    return  rgb;
}

+(UIImage *)kXGImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
