//
//  XGGlobalURL.m
//  XGCG
//
//  Created by Owen on 14-10-29.
//  Copyright (c) 2014年 renren. All rights reserved.
//

#import "XGGlobalURL.h"

@implementation XGGlobalURL


// TODO
#if DEBUG
NSString *kHostUrl()
{
    return @"http://101.200.175.189:8060";
}

#else
NSString *kHostUrl()
{
    return @"http://101.200.175.189:8060";
}

#endif
@end
