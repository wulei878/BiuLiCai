//
//  XGGlobalVariables.h
//  XGCG
//
//  Created by Owen on 14-10-29.
//  Copyright (c) 2014年 renren. All rights reserved.
//

#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)

#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)

#define kNavigationBarHeight 44

#define kStatusBarHeight 20

#define IS_IPHONE_6 ([[UIScreen mainScreen] bounds].size.height == 667.0)

///安全调用block
#define PTInvokeBlock(block, ...) \
    if (block) \
        block(__VA_ARGS__)

@protocol PTFactoryProtocol <NSObject>
+ (instancetype)getInstance;
@end

static NSString *UmengAppkey = @"555235f5e0f55a38220019ad";
static NSString *RONGCLOUD_IM_APPKEY = @"p5tvi9dst0kx4";

@interface XGGlobalVariables : NSObject
extern NSString * kCurrentUserDefaultPersistPath;
extern NSString * kDistrictPersisPath;
@end

extern NSString *kUUIDString();